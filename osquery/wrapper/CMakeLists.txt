# osquery C wrapper for CGO integration
# 基于 osquery_main 依赖链，删除 GhostTrace 不需要的模块
# 编译为静态库，由 Agent 通过 CGO 直接链接

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
