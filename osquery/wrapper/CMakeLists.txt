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

# ── 安装所有传递依赖的静态库 ──────────────────────────────

# osquery 核心库
set(_OSQUERY_LIBS
  osquery_core osquery_core_init osquery_core_plugins osquery_core_sql
  osquery_sql
  osquery_database osquery_database_ephemeral
  osquery_dispatcher
  osquery_extensions osquery_extensions_implthrift osquery_extensions_extensionsinterface
  osquery_filesystem osquery_hashing osquery_config
  osquery_events osquery_events_eventsregistry
  osquery_experimental_eventsstream_registry
  osquery_logger_datalogger
  osquery_process
  osquery_numericmonitoring
  osquery_registry
  osquery_remote_enroll_tlsenroll
  osquery_utils osquery_utils_conversions osquery_utils_info
  osquery_utils_json osquery_utils_status osquery_utils_config
  osquery_utils_pidfile osquery_utils_linux
  osquery_utils_system_systemutils osquery_utils_system_boottime
  osquery_utils_system_env osquery_utils_system_errno
  osquery_utils_system_filepath osquery_utils_system_time osquery_utils_system_uptime
  osquery_tables_system_systemtable osquery_tables_networking
  osquery_tables_yara_yaratable osquery_tables_applications
  osquery_tables_events_eventstable osquery_tables_utility_utilitytable
  osquery_tables_forensic osquery_tables_sleuthkit_sleuthkittable
  osquery_worker_ipc_tableipcjsonconverter
  osquery_worker_ipc_linux_tablecontaineripc osquery_worker_ipc_linux_tableipc
  osquery_worker_ipc_posix_pipechannel
  osquery_worker_logging_glog_logger osquery_worker_system_linux_memory
)

# 插件库
set(_PLUGIN_LIBS
  plugins_config_filesystemconfig plugins_config_parsers
  plugins_database_sqliteplugin
  plugins_logger_buffered plugins_logger_filesystemlogger plugins_logger_stdout plugins_logger_syslog
  plugins_remote_enroll_tlsenroll
)

# 安装 osquery 和插件库
foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      install(FILES "$<TARGET_FILE:${dep}>" DESTINATION ${CMAKE_INSTALL_LIBDIR})
    endif()
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

# 收集所有依赖库路径
set(_DEPS "")
foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      list(APPEND _DEPS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/lib${dep}.a")
    endif()
  endif()
endforeach()

# 第三方库
foreach(lib openssl gflags glog)
  set(_tgt "thirdparty_${lib}")
  if(TARGET ${_tgt})
    list(APPEND _DEPS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/lib${_tgt}.a")
  endif()
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
