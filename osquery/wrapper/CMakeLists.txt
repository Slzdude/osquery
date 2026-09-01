# osquery C wrapper for GhostTrace
# 编译为静态库，通过 cmake install 生成完整 SDK 包 + pkg-config

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

# ── 安装目标列表 ──────────────────────────────────────────

# osquery 核心库
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

# 第三方库（跨平台）
set(_THIRDPARTY_CROSS
  thirdparty_boost thirdparty_openssl thirdparty_gflags thirdparty_glog
  thirdparty_sqlite thirdparty_zlib thirdparty_zstd thirdparty_bzip2 thirdparty_lz4 thirdparty_lzma
  thirdparty_libarchive thirdparty_thrift thirdparty_yara
  thirdparty_sleuthkit_auto thirdparty_sleuthkit_base thirdparty_sleuthkit_fs
  thirdparty_sleuthkit_fs_cpp thirdparty_sleuthkit_hashdb
  thirdparty_sleuthkit_img thirdparty_sleuthkit_pool
  thirdparty_sleuthkit_util thirdparty_sleuthkit_vs
  thirdparty_linenoise-ng
)

# Linux-only 第三方库
set(_THIRDPARTY_LINUX "")
if(DEFINED PLATFORM_LINUX)
  set(_THIRDPARTY_LINUX
    thirdparty_util-linux thirdparty_libcap thirdparty_libaudit
    thirdparty_libudev thirdparty_dbus
    thirdparty_libmagic thirdparty_augeas
    thirdparty_libdpkg_dpkg thirdparty_libdpkg_compat
    thirdparty_libgcrypt thirdparty_libgpg-error
    thirdparty_libcryptsetup thirdparty_libdevmapper
    thirdparty_libiptc
    thirdparty_librpm thirdparty_popt
    thirdparty_gnulib_library
  )
endif()

set(_ALL_THIRDPARTY ${_THIRDPARTY_CROSS} ${_THIRDPARTY_LINUX})

# ── 安装规则 ────────────────────────────────────────────────

# wrapper + header
install(TARGETS osquery_wrapper ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES wrapper.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# osquery + plugin 库
foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      install(FILES "$<TARGET_FILE:${dep}>" DESTINATION ${CMAKE_INSTALL_LIBDIR})
    endif()
  endif()
endforeach()

# 第三方库（从构建目录安装）
foreach(dep ${_ALL_THIRDPARTY})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      install(FILES "$<TARGET_FILE:${dep}>" DESTINATION ${CMAKE_INSTALL_LIBDIR})
    endif()
  endif()
endforeach()

# gnulib（augeas 依赖，不在标准 target 中）
if(DEFINED PLATFORM_LINUX)
  install(CODE "
    set(_gnulib \"${CMAKE_BINARY_DIR}/libs/src/augeas/gnulib/libthirdparty_gnulib_library.a\")
    if(EXISTS \"\${_gnulib}\")
      file(INSTALL \"\${_gnulib}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}\")
    endif()
  ")
endif()

# specs 表库
install(CODE "
  file(MAKE_DIRECTORY \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps\")
  foreach(tgt codegen_native_tables codegen_foreign_tables)
    set(src \"${CMAKE_BINARY_DIR}/specs/lib\${tgt}.a\")
    if(EXISTS \"\${src}\")
      file(INSTALL \"\${src}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps\")
    endif()
  endforeach()
")

# 补充第三方库（cmake install 可能遗漏的）
install(CODE "
  # 递归搜索所有 .a 文件
  file(GLOB_RECURSE _extra_libs \"${CMAKE_BINARY_DIR}/libs/src/*.a\")
  file(GLOB _openssl_libs \"${CMAKE_BINARY_DIR}/openssl/openssl-prefix/src/openssl/lib*.a\")
  file(GLOB _formula_libs \"${CMAKE_BINARY_DIR}/installed_formulas/*/lib64/*.a\" \"${CMAKE_BINARY_DIR}/installed_formulas/*/lib/*.a\")

  foreach(lib \${_extra_libs} \${_openssl_libs} \${_formula_libs})
    if(EXISTS \"\${lib}\")
      get_filename_component(_name \"\${lib}\" NAME)
      set(_dest \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/\${_name}\")
      if(NOT EXISTS \"\${_dest}\")
        file(INSTALL \"\${lib}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}\")
      endif()
    endif()
  endforeach()
")

# ── pkg-config（install 时生成，避免 configure 时文件不存在）──

# specs 表路径
set(_SPECS "")
foreach(tgt codegen_native_tables codegen_foreign_tables)
  set(_SPECS "${_SPECS} ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/deps/lib${tgt}.a")
endforeach()

# C++ 运行时
set(_CXX "")
if(OSQUERY_TOOLCHAIN_SYSROOT)
  set(_CXX "${OSQUERY_TOOLCHAIN_SYSROOT}/usr/lib/libc++.a ${OSQUERY_TOOLCHAIN_SYSROOT}/usr/lib/libc++abi.a")
elseif(DEFINED PLATFORM_MACOS)
  set(_CXX "-lc++ -lc++abi")
endif()

# osquery + plugin 库路径
set(_DEPS "")
foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS})
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      set(_DEPS "${_DEPS} ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/lib${dep}.a")
    endif()
  endif()
endforeach()

# 在 install 时扫描已安装的第三方库并生成 .pc
install(CODE "
  # osquery + plugin 库
  set(_pc_deps \"${_DEPS}\")

  # 扫描已安装的第三方库
  file(GLOB _installed_tp \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/libthirdparty_*.a\")
  foreach(lib \${_installed_tp})
    set(_pc_deps \"\${_pc_deps} \${lib}\")
  endforeach()

  # OpenSSL
  foreach(lib libssl.a libcrypto.a)
    set(_p \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/\${lib}\")
    if(EXISTS \"\${_p}\")
      set(_pc_deps \"\${_pc_deps} \${_p}\")
    endif()
  endforeach()

  # 系统库
  set(_pc_deps \"\${_pc_deps} -lm -lpthread -ldl -lresolv -lrt\")

  # 构建 Libs 行
  string(STRIP \"\${_pc_deps}\" _pc_deps)
  set(_libs_line \"-L\\\${libdir} -Wl,--whole-archive ${_SPECS} -Wl,--no-whole-archive -Wl,--allow-multiple-definition -Wl,--start-group -losquery_wrapper \${_pc_deps} ${_CXX} -Wl,--end-group\")

  # 写入 .pc 文件
  file(MAKE_DIRECTORY \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/pkgconfig\")
  file(WRITE \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/pkgconfig/osquery_wrapper.pc\"
\"prefix=${CMAKE_INSTALL_PREFIX}
exec_prefix=\\\${prefix}
libdir=\\\${prefix}/${CMAKE_INSTALL_LIBDIR}
includedir=\\\${prefix}/${CMAKE_INSTALL_INCLUDEDIR}

Name: osquery_wrapper
Description: osquery SQL engine C wrapper for GhostTrace
Version: ${OSQUERY_VERSION}
Requires:
Libs: \${_libs_line}
Cflags: -I\\\${includedir}
\")
")
