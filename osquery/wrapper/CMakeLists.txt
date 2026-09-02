# osquery C wrapper for GhostTrace
# 编译为静态库，通过 cmake install 生成完整 SDK 包 + pkg-config
# 支持三端：Linux (POSIX), macOS (POSIX), Windows

include(GNUInstallDirs)

# ── Wrapper 静态库 ──────────────────────────────────────────

set(_WRAPPER_SOURCES wrapper.cpp)

add_osquery_library(osquery_wrapper STATIC
  ${_WRAPPER_SOURCES}
)

# ── 链接依赖（按平台区分）──────────────────────────────────

set(_WRAPPER_DEPS
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

# POSIX 专属
if(DEFINED PLATFORM_POSIX)
  list(APPEND _WRAPPER_DEPS
    osquery_worker_ipc_posix_pipechannel
  )
endif()

# Linux 专属
if(DEFINED PLATFORM_LINUX)
  list(APPEND _WRAPPER_DEPS
    osquery_worker_ipc_linux_tablecontaineripc
    osquery_worker_ipc_linux_tableipc
    osquery_worker_system_linux_memory
  )
endif()

# Windows 专属
if(DEFINED PLATFORM_WINDOWS)
  list(APPEND _WRAPPER_DEPS
    plugins_logger_windowseventlog
  )
endif()

target_link_libraries(osquery_wrapper PUBLIC ${_WRAPPER_DEPS})

# ── 安装目标列表 ──────────────────────────────────────────

# osquery 核心库（跨平台）
set(_OSQUERY_LIBS
  osquery_core osquery_core_init osquery_core_plugins osquery_core_sql
  osquery_sql osquery_database osquery_database_ephemeral
  osquery_dispatcher osquery_extensions osquery_extensions_implthrift osquery_extensions_extensionsinterface
  osquery_filesystem osquery_hashing osquery_config
  osquery_events osquery_events_eventsregistry osquery_experimental_eventsstream_registry
  osquery_logger_datalogger osquery_process osquery_numericmonitoring
  osquery_registry osquery_remote_enroll_tlsenroll
  osquery_utils osquery_utils_conversions osquery_utils_info osquery_utils_json
  osquery_utils_status osquery_utils_config osquery_utils_pidfile
  osquery_utils_system_systemutils osquery_utils_system_boottime osquery_utils_system_env
  osquery_utils_system_errno osquery_utils_system_filepath osquery_utils_system_time osquery_utils_system_uptime
  osquery_tables_system_systemtable osquery_tables_networking osquery_tables_yara_yaratable
  osquery_tables_applications osquery_tables_events_eventstable osquery_tables_utility_utilitytable
  osquery_tables_forensic osquery_tables_sleuthkit_sleuthkittable
  osquery_worker_ipc_tableipcjsonconverter
  osquery_worker_logging_glog_logger
)

# POSIX 专属库
if(DEFINED PLATFORM_POSIX)
  list(APPEND _OSQUERY_LIBS
    osquery_utils_linux
    osquery_worker_ipc_posix_pipechannel
  )
endif()

# Linux 专属库
if(DEFINED PLATFORM_LINUX)
  list(APPEND _OSQUERY_LIBS
    osquery_worker_ipc_linux_tablecontaineripc
    osquery_worker_ipc_linux_tableipc
    osquery_worker_system_linux_memory
  )
endif()

# 插件库（跨平台）
set(_PLUGIN_LIBS
  plugins_config_filesystemconfig plugins_config_parsers
  plugins_database_sqliteplugin
  plugins_logger_buffered plugins_logger_filesystemlogger plugins_logger_stdout plugins_logger_syslog
  plugins_remote_enroll_tlsenroll
)

# Windows 专属插件
if(DEFINED PLATFORM_WINDOWS)
  list(APPEND _PLUGIN_LIBS
    plugins_logger_windowseventlog
  )
endif()

# ── 第三方库 ──────────────────────────────────────────────

# 跨平台第三方库
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

# Linux 专属第三方库
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

# macOS 专属第三方库（macOS 上不适用的 Linux 库已在 _THIRDPARTY_LINUX 中排除）
set(_THIRDPARTY_MACOS "")
if(DEFINED PLATFORM_MACOS)
  set(_THIRDPARTY_MACOS
    # macOS 使用系统 libmagic，不需要 thirdparty_libmagic
    # macOS 使用系统 libarchive，不需要 thirdparty_libarchive（但 osquery 仍链接）
  )
endif()

# Windows 专属第三方库
set(_THIRDPARTY_WINDOWS "")
if(DEFINED PLATFORM_WINDOWS)
  set(_THIRDPARTY_WINDOWS
    # Windows 使用 krabsetw 用于 ETW 事件
    thirdparty_krabsetw
  )
endif()

set(_ALL_THIRDPARTY ${_THIRDPARTY_CROSS} ${_THIRDPARTY_LINUX} ${_THIRDPARTY_MACOS} ${_THIRDPARTY_WINDOWS})

# ── Windows 合并静态库 ──────────────────────────────────────
# 将 wrapper + 所有 osquery 依赖合并为单一 .lib
# 这样 MinGW (Go CGO) 只需链接这一个 .lib，无需解析 C++ 符号

if(DEFINED PLATFORM_WINDOWS)
  # 收集所有需要合并的库
  set(_COMBINE_LIBS
    $<TARGET_FILE:osquery_wrapper>
  )

  # osquery 核心库
  foreach(dep ${_OSQUERY_LIBS} ${_PLUGIN_LIBS})
    if(TARGET ${dep})
      get_target_property(dep_type ${dep} TYPE)
      if(dep_type STREQUAL "STATIC_LIBRARY")
        list(APPEND _COMBINE_LIBS $<TARGET_FILE:${dep}>)
      endif()
    endif()
  endforeach()

  # 第三方库
  foreach(dep ${_ALL_THIRDPARTY})
    if(TARGET ${dep})
      get_target_property(dep_type ${dep} TYPE)
      if(dep_type STREQUAL "STATIC_LIBRARY")
        list(APPEND _COMBINE_LIBS $<TARGET_FILE:${dep}>)
      endif()
    endif()
  endforeach()

  # specs 表库
  foreach(tgt codegen_native_tables codegen_foreign_tables)
    if(TARGET ${tgt})
      list(APPEND _COMBINE_LIBS $<TARGET_FILE:${tgt}>)
    endif()
  endforeach()

  # 使用 lib.exe 合并所有 .lib 为单一文件
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/osquery_combined.lib
    COMMAND lib.exe /nologo /OUT:${CMAKE_CURRENT_BINARY_DIR}/osquery_combined.lib ${_COMBINE_LIBS}
    DEPENDS osquery_wrapper ${_OSQUERY_LIBS} ${_PLUGIN_LIBS} ${_ALL_THIRDPARTY}
    COMMENT "Combining all libraries into osquery_combined.lib"
  )

  add_custom_target(osquery_wrapper_combined ALL
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/osquery_combined.lib
  )

  # 安装合并后的 .lib
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/osquery_combined.lib
    DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()

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

# gnulib（augeas 依赖，Linux only）
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
      file(INSTALL \"\${src}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}\")
    endif()
  endforeach()
")

# 注：补充第三方库由 CI 的 find 命令完成，不再在 cmake install 中递归扫描

# ── pkg-config ──────────────────────────────────────────────
# 仅 Linux 使用 pkg-config（macOS 用 -framework，Windows 用 cmake）

if(DEFINED PLATFORM_LINUX OR DEFINED PLATFORM_MACOS)

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

  # 事件库（需要 --whole-archive 以确保 Publisher/Subscriber 注册）
  set(_WHOLE_ARCHIVE_LIBS "")
  foreach(dep osquery_events osquery_events_eventsregistry osquery_tables_events_eventstable)
    if(TARGET ${dep})
      get_target_property(dep_type ${dep} TYPE)
      if(dep_type STREQUAL "STATIC_LIBRARY")
        set(_WHOLE_ARCHIVE_LIBS "${_WHOLE_ARCHIVE_LIBS} ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/lib${dep}.a")
      endif()
    endif()
  endforeach()

  # 平台相关的链接器标志
  set(_EXTRA_LDFLAGS "")
  set(_SYSTEM_LIBS "")
  set(_WHOLE_ARCHIVE_START "")
  set(_WHOLE_ARCHIVE_END "")
  set(_GROUP_START "")
  set(_GROUP_END "")

  if(DEFINED PLATFORM_LINUX)
    set(_SYSTEM_LIBS "-lm -lpthread -ldl -lresolv -lrt")
    set(_WHOLE_ARCHIVE_START "-Wl,--whole-archive")
    set(_WHOLE_ARCHIVE_END "-Wl,--no-whole-archive")
    set(_EXTRA_LDFLAGS "-Wl,--allow-multiple-definition")
    set(_GROUP_START "-Wl,--start-group")
    set(_GROUP_END "-Wl,--end-group")
  elseif(DEFINED PLATFORM_MACOS)
    set(_SYSTEM_LIBS "-lm -lpthread")
    # macOS 用 -force_load 替代 --whole-archive
    set(_WHOLE_ARCHIVE_START "")
    set(_WHOLE_ARCHIVE_END "")
    set(_EXTRA_LDFLAGS "")
    set(_GROUP_START "")
    set(_GROUP_END "")
    # 为每个需要 whole-archive 的库生成 -force_load
    set(_FORCE_LOAD "")
    foreach(lib ${_WHOLE_ARCHIVE_LIBS})
      set(_FORCE_LOAD "${_FORCE_LOAD} -force_load ${lib}")
    endforeach()
    set(_WHOLE_ARCHIVE_LIBS "${_FORCE_LOAD}")
  endif()

  # 在 install 时生成 .pc
  install(CODE "
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
    set(_pc_deps \"\${_pc_deps} ${_SYSTEM_LIBS}\")

    # 构建 Libs 行
    string(STRIP \"\${_pc_deps}\" _pc_deps)
    set(_libs_line \"-L\\\${libdir} ${_WHOLE_ARCHIVE_START} ${_SPECS} ${_WHOLE_ARCHIVE_LIBS} ${_WHOLE_ARCHIVE_END} ${_EXTRA_LDFLAGS} ${_GROUP_START} -losquery_wrapper \${_pc_deps} ${_CXX} ${_GROUP_END}\")

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

endif() # PLATFORM_LINUX OR PLATFORM_MACOS
