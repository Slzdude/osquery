# osquery C wrapper for CGO integration
# 编译为静态库，CMake 自动处理依赖顺序和循环依赖

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

# 安装 wrapper 和生成 pkg-config
install(TARGETS osquery_wrapper
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
)

install(FILES wrapper.h DESTINATION include)

# 收集所有传递依赖的静态库路径
# pkg-config 的 Libs.private 会包含所有依赖
set(OSQUERY_WRAPPER_LIBS "")
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
      list(APPEND OSQUERY_WRAPPER_LIBS "$<TARGET_FILE:${dep}>")
    endif()
  endif()
endforeach()
