# osquery C wrapper for GhostTrace
# 编译为静态库，通过 cmake install 生成完整 SDK 包
#
# 依赖列表需要手动维护（cmake 无法自动遍历传递依赖）。
# 新增依赖时在此处添加即可。

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

# ── 需要安装到 SDK 的所有静态库 ─────────────────────────────
# 按类别组织，便于维护

# osquery 核心 + 表 + 工具
set(_OSQUERY_LIBS
  osquery_core osquery_core_init osquery_core_plugins osquery_core_sql
  osquery_sql osquery_database osquery_database_ephemeral
  osquery_dispatcher osquery_extensions osquery_extensions_implthrift osquery_extensions_extensionsinterface
  osquery_filesystem osquery_hashing osquery_config
  osquery_events osquery_events_eventsregistry osquery_experimental_eventsstream_registry
  osquery_logger_datalogger osquery_process osquery_numericmonitoring
  osquery_registry osquery_remote_enroll_tlsenroll
  osquery_utils osquery_utils_conversions osquery_utils_info osquery_utils_json
  osquery_utils_status osquery_utils_config osquery_utils_pidfile osquery_utils_linux
  osquery_utils_system_systemutils osquery_utils_system_boottime osquery_utils_system_env
  osquery_utils_system_errno osquery_utils_system_filepath osquery_utils_system_time osquery_utils_system_uptime
  osquery_tables_system_systemtable osquery_tables_networking osquery_tables_yara_yaratable
  osquery_tables_applications osquery_tables_events_eventstable osquery_tables_utility_utilitytable
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

# 第三方库（名称可能因平台而异，用 GLOB 补充）
set(_THIRDPARTY_LIBS
  thirdparty_boost thirdparty_openssl thirdparty_gflags thirdparty_glog
  thirdparty_sqlite thirdparty_zlib thirdparty_zstd thirdparty_bzip2 thirdparty_lz4 thirdparty_lzma
  thirdparty_libarchive thirdparty_thrift thirdparty_yara
)

# ── 安装规则 ────────────────────────────────────────────────

# wrapper + header
install(TARGETS osquery_wrapper ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES wrapper.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# 安装所有静态库
foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS} ${_THIRDPARTY_LIBS})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      install(FILES "$<TARGET_FILE:${dep}>" DESTINATION ${CMAKE_INSTALL_LIBDIR})
    endif()
  endif()
endforeach()

# specs 表库（需要 --whole-archive）
install(CODE "
  file(MAKE_DIRECTORY \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps\")
  foreach(tgt codegen_native_tables codegen_foreign_tables)
    set(src \"${CMAKE_BINARY_DIR}/specs/lib\${tgt}.a\")
    if(EXISTS \"\${src}\")
      file(INSTALL \"\${src}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps\")
    endif()
  endforeach()
")

# 补充安装构建目录中的第三方库（cmake install 可能遗漏的）
install(CODE "
  file(GLOB _extra_libs
    \"${CMAKE_BINARY_DIR}/libs/src/*/*.a\"
    \"${CMAKE_BINARY_DIR}/installed_formulas/*/lib64/*.a\"
    \"${CMAKE_BINARY_DIR}/installed_formulas/*/lib/*.a\"
    \"${CMAKE_BINARY_DIR}/openssl/openssl-prefix/src/openssl/lib*.a\"
  )
  foreach(lib \${_extra_libs})
    if(EXISTS \"\${lib}\")
      get_filename_component(_name \"\${lib}\" NAME)
      set(_dest \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/\${_name}\")
      if(NOT EXISTS \"\${_dest}\")
        file(INSTALL \"\${lib}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}\")
      endif()
    endif()
  endforeach()
")

# ── pkg-config ──────────────────────────────────────────────

# 收集 specs 表路径
set(_SPECS_LIBS "")
foreach(tgt codegen_native_tables codegen_foreign_tables)
  list(APPEND _SPECS_LIBS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps/lib${tgt}.a")
endforeach()
string(REPLACE ";" " " SPECS_LIBS "${_SPECS_LIBS}")

# 收集所有依赖库路径
set(_DEPS "")
foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS} ${_THIRDPARTY_LIBS})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      list(APPEND _DEPS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/lib${dep}.a")
    endif()
  endif()
endforeach()
list(APPEND _DEPS "-lm -lpthread -ldl -lresolv -lrt")
string(REPLACE ";" " " DEPS_LIBS "${_DEPS}")

# C++ 运行时（osquery 用 libc++ 编译）
if(OSQUERY_TOOLCHAIN_SYSROOT)
  set(CXX_RUNTIME "${OSQUERY_TOOLCHAIN_SYSROOT}/usr/lib/libc++.a ${OSQUERY_TOOLCHAIN_SYSROOT}/usr/lib/libc++abi.a")
elseif(DEFINED PLATFORM_MACOS)
  set(CXX_RUNTIME "-lc++ -lc++abi")
elseif(DEFINED PLATFORM_WINDOWS)
  set(CXX_RUNTIME "")
endif()

set(COMPAT_STUB "")

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/osquery_wrapper.pc.in"
  "${CMAKE_CURRENT_BINARY_DIR}/osquery_wrapper.pc"
  @ONLY
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/osquery_wrapper.pc"
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/pkgconfig"
)
