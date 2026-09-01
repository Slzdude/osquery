# osquery C wrapper for CGO integration
# 编译为静态库，通过 cmake install 生成 SDK 包

add_osquery_library(osquery_wrapper STATIC
  wrapper.cpp
)

target_link_libraries(osquery_wrapper PUBLIC
  osquery_cxx_settings

  # 核心
  osquery_core
  osquery_core_init
  osquery_core_plugins
  osquery_core_sql

  # SQL 引擎
  osquery_sql

  # 配置
  plugins_config_filesystemconfig
  plugins_config_parsers

  # 数据库
  osquery_database
  plugins_database_sqliteplugin

  # 调度器
  osquery_dispatcher

  # 事件系统
  osquery_experimental_eventsstream_registry

  # 扩展
  osquery_extensions
  osquery_extensions_implthrift

  # 日志
  osquery_logger_datalogger
  plugins_logger_buffered
  plugins_logger_filesystemlogger
  plugins_logger_stdout
  plugins_logger_syslog

  # 进程
  osquery_process

  # 监控
  osquery_numericmonitoring

  # 注册表
  osquery_registry

  # 远程
  osquery_remote_enroll_tlsenroll
  plugins_remote_enroll_tlsenroll

  # 表
  specs_tables

  # 第三方库
  thirdparty_boost
)

# ── 安装目标 ──────────────────────────────────────────────

install(TARGETS osquery_wrapper
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)

install(FILES wrapper.h DESTINATION include)

# ── 收集所有传递依赖的静态库路径 ──────────────────────────
# 用于生成 pkg-config 文件

set(_ALL_DEPS "")

# wrapper 直接依赖
foreach(dep
    osquery_wrapper
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
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      list(APPEND _ALL_DEPS "$<TARGET_FILE:${dep}>")
    endif()
  endif()
endforeach()

# 安装所有依赖的静态库到 lib/deps/
install(CODE "
  file(MAKE_DIRECTORY \"\${CMAKE_INSTALL_PREFIX}/lib/deps\")
  foreach(dep ${_ALL_DEPS})
    if(EXISTS \"\${dep}\")
      file(INSTALL \"\${dep}\" DESTINATION \"\${CMAKE_INSTALL_PREFIX}/lib/deps\")
    endif()
  endforeach()
")

# ── 生成 pkg-config 文件 ──────────────────────────────────

set(OSQUERY_WRAPPER_PC "${CMAKE_CURRENT_BINARY_DIR}/osquery_wrapper.pc")

# 收集所有依赖的 .a 文件名
set(_LIBS_PRIVATE "")
foreach(dep
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
  if(TARGET ${dep})
    get_target_property(dep_type ${dep} TYPE)
    if(dep_type STREQUAL "STATIC_LIBRARY")
      get_target_property(dep_loc ${dep} IMPORTED_LOCATION)
      if(NOT dep_loc)
        # 对于非 IMPORTED 目标，使用构建目录中的路径
        set(dep_loc "${CMAKE_BINARY_DIR}/lib/lib${dep}.a")
      endif()
      list(APPEND _LIBS_PRIVATE "${dep_loc}")
    endif()
  endif()
endforeach()

# 收集第三方库路径
set(_THIRD_PARTY_LIBS "")
foreach(lib
    openssl gflags glog boost bzip2 zlib libarchive zstd lz4 lzma
    sqlite thrift yara sleuthkit libmagic augeas
    libaudit libudev libdpkg libgcrypt libgpg-error libiptables
    librpm libcap libcryptsetup libdevmapper dbus librdkafka popt linenoise-ng util-linux
)
  if(TARGET thirdparty_${lib})
    get_target_property(lib_loc thirdparty_${lib} IMPORTED_LOCATION)
    if(lib_loc)
      list(APPEND _THIRD_PARTY_LIBS "${lib_loc}")
    endif()
  endif()
endforeach()

# 生成 .pc 文件（相对路径，可移植）
# Libs.private 列出所有依赖的完整路径
set(_LIBS_PRIVATE_STR "")
foreach(lib ${_ALL_DEPS})
  string(APPEND _LIBS_PRIVATE_STR "${lib} ")
endforeach()

file(WRITE "${OSQUERY_WRAPPER_PC}"
"# osquery wrapper pkg-config file
prefix=${CMAKE_INSTALL_PREFIX}
exec_prefix=\${prefix}
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: osquery_wrapper
Description: osquery SQL engine C wrapper
Version: ${OSQUERY_VERSION}
Requires:
Libs: -L\${libdir} -losquery_wrapper
Libs.private: ${_LIBS_PRIVATE_STR}
Cflags: -I\${includedir}
")

install(FILES "${OSQUERY_WRAPPER_PC}" DESTINATION lib/pkgconfig)
