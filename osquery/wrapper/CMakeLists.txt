# osquery C wrapper for CGO integration
# 基于 osquery_main 依赖链，删除 GhostTrace 不需要的模块

add_osquery_library(osquery_wrapper SHARED
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

  # 配置（保留 filesystemconfig 和 parsers，删除 tlsconfig 和 updateconfigplugin）
  plugins_config_filesystemconfig
  plugins_config_parsers

  # 数据库（保留 sqlite，删除 rocksdb）
  osquery_database
  plugins_database_sqliteplugin

  # 调度器
  osquery_dispatcher

  # 事件系统
  osquery_experimental_eventsstream_registry

  # 扩展
  osquery_extensions
  osquery_extensions_implthrift

  # 日志（保留 stdout/buffered/filesystemlogger/syslog，删除 tlslogger/kafkaproducer）
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

  # 远程（保留 enroll，删除分布式 TLS）
  osquery_remote_enroll_tlsenroll
  plugins_remote_enroll_tlsenroll

  # 表
  specs_tables

  # 第三方库
  thirdparty_boost

  # 删除的模块（仅 osquery_main 引用，无其他依赖）：
  # - osquery_devtools              (shell 专用)
  # - osquery_extensions_implthrift (Thrift 通信)
  # - plugins_logger_tlslogger      (TLS 日志)
  # - plugins_logger_kafkaproducer  (Kafka 日志)
  # - plugins_config_tlsconfig      (TLS 配置)
  # - plugins_config_updateconfigplugin (动态配置更新)
  # - plugins_distributed_tls_distributedtls (分布式查询)
  # - plugins_database_rocksdbplugin (RocksDB 持久化，我们用内存数据库)
)

# 跨平台链接和导出配置
if(DEFINED PLATFORM_LINUX)
  # Linux: 静态链接 libc++，使用 version script 控制符号可见性
  target_link_libraries(osquery_wrapper PRIVATE
    ${OSQUERY_TOOLCHAIN_SYSROOT}/usr/lib/libc++.a
    ${OSQUERY_TOOLCHAIN_SYSROOT}/usr/lib/libc++abi.a
  )
  target_link_options(osquery_wrapper PRIVATE
    -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/osquery_wrapper.map
  )

elseif(DEFINED PLATFORM_MACOS)
  # macOS: 系统 libc++，使用 exported_symbols_list
  target_link_options(osquery_wrapper PRIVATE
    -Wl,-exported_symbols_list,${CMAKE_CURRENT_SOURCE_DIR}/osquery_wrapper.exp
  )

elseif(DEFINED PLATFORM_WINDOWS)
  # Windows: MSVC 运行时，__declspec(dllexport) 通过编译定义控制
  target_compile_definitions(osquery_wrapper PRIVATE
    OSQUERY_WRAPPER_EXPORTS
  )
endif()
