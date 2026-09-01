# osquery C wrapper for GhostTrace
# 编译为静态库，通过 cmake install 生成完整 SDK 包

include(GNUInstallDirs)

# ── Wrapper 静态库 ──────────────────────────────────────────

add_osquery_library(osquery_wrapper STATIC
  wrapper.cpp
)

target_link_libraries(osquery_wrapper PUBLIC
  osquery_cxx_settings
  osquery_core osquery_core_init osquery_core_plugins osquery_core_sql
  osquery_sql
  plugins_config_filesystemconfig plugins_config_parsers
  osquery_database plugins_database_sqliteplugin
  osquery_dispatcher
  osquery_experimental_eventsstream_registry
  osquery_extensions osquery_extensions_implthrift
  osquery_logger_datalogger plugins_logger_buffered plugins_logger_filesystemlogger plugins_logger_stdout plugins_logger_syslog
  osquery_process
  osquery_numericmonitoring
  osquery_registry
  osquery_remote_enroll_tlsenroll plugins_remote_enroll_tlsenroll
  specs_tables
  thirdparty_boost
)

# ── 安装 wrapper + header ──────────────────────────────────

install(TARGETS osquery_wrapper
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(FILES wrapper.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# ── 自动发现并安装所有传递依赖 ────────────────────────────

# 递归收集目标的所有静态库传递依赖
set(_COLLECTED_DEPS "")
set(_SEEN_DEPS "")
macro(collect_static_deps target)
  if(NOT TARGET ${target})
    return()
  endif()
  # 跳过已处理的目标
  list(FIND _SEEN_DEPS "${target}" _idx)
  if(NOT _idx EQUAL -1)
    return()
  endif()
  list(APPEND _SEEN_DEPS "${target}")

  get_target_property(_type ${target} TYPE)
  if(_type STREQUAL "STATIC_LIBRARY")
    list(APPEND _COLLECTED_DEPS "${target}")
  endif()

  # 递归处理 PUBLIC 和 INTERFACE 依赖
  get_target_property(_pub_deps ${target} INTERFACE_LINK_LIBRARIES)
  if(_pub_deps)
    foreach(_dep ${_pub_deps})
      if(TARGET "${_dep}")
        collect_static_deps("${_dep}")
      endif()
    endforeach()
  endif()

  get_target_property(_link_deps ${target} LINK_LIBRARIES)
  if(_link_deps)
    foreach(_dep ${_link_deps})
      if(TARGET "${_dep}")
        collect_static_deps("${_dep}")
      endif()
    endforeach()
  endif()
endmacro()

# 从 wrapper 开始递归收集
collect_static_deps(osquery_wrapper)

# 安装所有收集到的静态库
foreach(dep ${_COLLECTED_DEPS})
  get_target_property(_loc ${dep} IMPORTED_LOCATION)
  if(_loc AND EXISTS "${_loc}")
    install(FILES "${_loc}" DESTINATION ${CMAKE_INSTALL_LIBDIR})
  else()
    # 非 IMPORTED 目标，从构建目录获取
    install(FILES "$<TARGET_FILE:${dep}>" DESTINATION ${CMAKE_INSTALL_LIBDIR})
  endif()
endforeach()

# 安装 specs 表库到 deps/
install(CODE "
  file(MAKE_DIRECTORY \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps\")
  foreach(tgt codegen_native_tables codegen_foreign_tables)
    set(src \"${CMAKE_BINARY_DIR}/specs/lib\${tgt}.a\")
    if(EXISTS \"\${src}\")
      file(INSTALL \"\${src}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps\")
    endif()
  endforeach()
")

# 安装第三方库（openssl, gflags, glog 等）
# 这些库在构建目录的 libs/ 或 installed_formulas/ 下
install(CODE "
  file(GLOB _thirdparty_libs
    \"${CMAKE_BINARY_DIR}/libs/src/*/*.a\"
    \"${CMAKE_BINARY_DIR}/installed_formulas/*/lib64/*.a\"
    \"${CMAKE_BINARY_DIR}/installed_formulas/*/lib/*.a\"
    \"${CMAKE_BINARY_DIR}/openssl/openssl-prefix/src/openssl/libssl.a\"
    \"${CMAKE_BINARY_DIR}/openssl/openssl-prefix/src/openssl/libcrypto.a\"
  )
  foreach(lib \${_thirdparty_libs})
    if(EXISTS \"\${lib}\")
      file(INSTALL \"\${lib}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}\")
    endif()
  endforeach()
")

# ── 生成 pkg-config ─────────────────────────────────────────

# 收集 specs 表路径
set(_SPECS_LIBS "")
foreach(tgt codegen_native_tables codegen_foreign_tables)
  if(TARGET ${tgt})
    list(APPEND _SPECS_LIBS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps/lib${tgt}.a")
  endif()
endforeach()
string(REPLACE ";" " " SPECS_LIBS "${_SPECS_LIBS}")

# 使用自动发现的依赖列表生成 pkg-config
set(_DEPS "")
foreach(dep ${_COLLECTED_DEPS})
  list(APPEND _DEPS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/lib${dep}.a")
endforeach()

# 系统库
list(APPEND _DEPS "-lm -lpthread -ldl -lresolv -lrt")

string(REPLACE ";" " " DEPS_LIBS "${_DEPS}")
set(COMPAT_STUB "")

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/osquery_wrapper.pc.in"
  "${CMAKE_CURRENT_BINARY_DIR}/osquery_wrapper.pc"
  @ONLY
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/osquery_wrapper.pc"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
)
