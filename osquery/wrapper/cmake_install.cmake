# Install script for directory: /home/work/projects/GhostTrace/external/osquery/osquery/wrapper

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/tmp/osquery-sdk")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/local/osquery-toolchain/usr/bin/llvm-objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/work/projects/GhostTrace/external/osquery/osquery/wrapper/libosquery_wrapper.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/wrapper/wrapper.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/core/libosquery_core.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/core/libosquery_core_init.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/core/plugins/libosquery_core_plugins.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/core/sql/libosquery_core_sql.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/sql/libosquery_sql.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/database/libosquery_database.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/database/libosquery_database_ephemeral.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/dispatcher/libosquery_dispatcher.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/extensions/libosquery_extensions.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/extensions/libosquery_extensions_implthrift.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/extensions/libosquery_extensions_extensionsinterface.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/filesystem/libosquery_filesystem.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/hashing/libosquery_hashing.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/config/libosquery_config.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/events/libosquery_events.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/events/libosquery_events_eventsregistry.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/experimental/events_stream/libosquery_experimental_eventsstream_registry.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/logger/libosquery_logger_datalogger.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/process/libosquery_process.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/numeric_monitoring/libosquery_numericmonitoring.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/registry/libosquery_registry.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/remote/enroll/libosquery_remote_enroll_tlsenroll.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/libosquery_utils.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/conversions/libosquery_utils_conversions.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/info/libosquery_utils_info.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/json/libosquery_utils_json.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/status/libosquery_utils_status.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/config/libosquery_utils_config.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/pidfile/libosquery_utils_pidfile.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/linux/libosquery_utils_linux.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_systemutils.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_boottime.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_env.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_errno.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_filepath.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_time.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/utils/system/libosquery_utils_system_uptime.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/system/libosquery_tables_system_systemtable.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/networking/libosquery_tables_networking.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/yara/libosquery_tables_yara_yaratable.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/applications/libosquery_tables_applications.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/events/libosquery_tables_events_eventstable.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/utility/libosquery_tables_utility_utilitytable.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/forensic/libosquery_tables_forensic.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/tables/sleuthkit/libosquery_tables_sleuthkit_sleuthkittable.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/worker/ipc/libosquery_worker_ipc_tableipcjsonconverter.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/worker/ipc/linux/libosquery_worker_ipc_linux_tablecontaineripc.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/worker/ipc/linux/libosquery_worker_ipc_linux_tableipc.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/worker/ipc/posix/libosquery_worker_ipc_posix_pipechannel.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/worker/logging/glog/libosquery_worker_logging_glog_logger.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/osquery/worker/system/libosquery_worker_system_linux_memory.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/gflags/libthirdparty_gflags.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/glog/libthirdparty_glog.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sqlite/libthirdparty_sqlite.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/zlib/libthirdparty_zlib.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/zstd/libthirdparty_zstd.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/bzip2/libthirdparty_bzip2.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/lz4/libthirdparty_lz4.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/lzma/libthirdparty_lzma.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libarchive/libthirdparty_libarchive.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/yara/libthirdparty_yara.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_auto.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_base.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_fs.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_fs_cpp.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_hashdb.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_img.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_pool.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_util.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/sleuthkit/libthirdparty_sleuthkit_vs.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/linenoise-ng/libthirdparty_linenoise-ng.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/util-linux/libthirdparty_util-linux.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libcap/libthirdparty_libcap.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libaudit/libthirdparty_libaudit.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libudev/libthirdparty_libudev.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/dbus/libthirdparty_dbus.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libmagic/libthirdparty_libmagic.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/augeas/libthirdparty_augeas.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libdpkg/libthirdparty_libdpkg_dpkg.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libdpkg/libthirdparty_libdpkg_compat.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libgcrypt/libthirdparty_libgcrypt.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libgpg-error/libthirdparty_libgpg-error.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libcryptsetup/libthirdparty_libcryptsetup.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libdevmapper/libthirdparty_libdevmapper.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/libiptables/libthirdparty_libiptc.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/librpm/libthirdparty_librpm.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/popt/libthirdparty_popt.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE FILE FILES "/home/work/projects/GhostTrace/external/osquery/libs/src/augeas/gnulib/libthirdparty_gnulib_library.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
    set(_gnulib "/home/work/projects/GhostTrace/external/osquery/libs/src/augeas/gnulib/libthirdparty_gnulib_library.a")
    if(EXISTS "${_gnulib}")
      file(INSTALL "${_gnulib}" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
    endif()
  
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib/deps")
  foreach(tgt codegen_native_tables codegen_foreign_tables)
    set(src "/home/work/projects/GhostTrace/external/osquery/specs/lib${tgt}.a")
    if(EXISTS "${src}")
      file(INSTALL "${src}" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/deps")
    endif()
  endforeach()

endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
  # 递归搜索所有 .a 文件
  file(GLOB_RECURSE _extra_libs "/home/work/projects/GhostTrace/external/osquery/libs/src/*.a")
  file(GLOB _openssl_libs "/home/work/projects/GhostTrace/external/osquery/openssl/openssl-prefix/src/openssl/lib*.a")
  file(GLOB _formula_libs "/home/work/projects/GhostTrace/external/osquery/installed_formulas/*/lib64/*.a" "/home/work/projects/GhostTrace/external/osquery/installed_formulas/*/lib/*.a")

  foreach(lib ${_extra_libs} ${_openssl_libs} ${_formula_libs})
    if(EXISTS "${lib}")
      get_filename_component(_name "${lib}" NAME)
      set(_dest "${CMAKE_INSTALL_PREFIX}/lib/${_name}")
      if(NOT EXISTS "${_dest}")
        file(INSTALL "${lib}" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
      endif()
    endif()
  endforeach()

endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  
  # osquery + plugin 库
  set(_pc_deps " /tmp/osquery-sdk/lib/libosquery_core.a /tmp/osquery-sdk/lib/libosquery_core_init.a /tmp/osquery-sdk/lib/libosquery_core_plugins.a /tmp/osquery-sdk/lib/libosquery_core_sql.a /tmp/osquery-sdk/lib/libosquery_sql.a /tmp/osquery-sdk/lib/libosquery_database.a /tmp/osquery-sdk/lib/libosquery_database_ephemeral.a /tmp/osquery-sdk/lib/libosquery_dispatcher.a /tmp/osquery-sdk/lib/libosquery_extensions.a /tmp/osquery-sdk/lib/libosquery_extensions_implthrift.a /tmp/osquery-sdk/lib/libosquery_extensions_extensionsinterface.a /tmp/osquery-sdk/lib/libosquery_filesystem.a /tmp/osquery-sdk/lib/libosquery_hashing.a /tmp/osquery-sdk/lib/libosquery_config.a /tmp/osquery-sdk/lib/libosquery_events.a /tmp/osquery-sdk/lib/libosquery_events_eventsregistry.a /tmp/osquery-sdk/lib/libosquery_experimental_eventsstream_registry.a /tmp/osquery-sdk/lib/libosquery_logger_datalogger.a /tmp/osquery-sdk/lib/libosquery_process.a /tmp/osquery-sdk/lib/libosquery_numericmonitoring.a /tmp/osquery-sdk/lib/libosquery_registry.a /tmp/osquery-sdk/lib/libosquery_remote_enroll_tlsenroll.a /tmp/osquery-sdk/lib/libosquery_utils.a /tmp/osquery-sdk/lib/libosquery_utils_conversions.a /tmp/osquery-sdk/lib/libosquery_utils_info.a /tmp/osquery-sdk/lib/libosquery_utils_json.a /tmp/osquery-sdk/lib/libosquery_utils_status.a /tmp/osquery-sdk/lib/libosquery_utils_config.a /tmp/osquery-sdk/lib/libosquery_utils_pidfile.a /tmp/osquery-sdk/lib/libosquery_utils_linux.a /tmp/osquery-sdk/lib/libosquery_utils_system_systemutils.a /tmp/osquery-sdk/lib/libosquery_utils_system_boottime.a /tmp/osquery-sdk/lib/libosquery_utils_system_env.a /tmp/osquery-sdk/lib/libosquery_utils_system_errno.a /tmp/osquery-sdk/lib/libosquery_utils_system_filepath.a /tmp/osquery-sdk/lib/libosquery_utils_system_time.a /tmp/osquery-sdk/lib/libosquery_utils_system_uptime.a /tmp/osquery-sdk/lib/libosquery_tables_system_systemtable.a /tmp/osquery-sdk/lib/libosquery_tables_networking.a /tmp/osquery-sdk/lib/libosquery_tables_yara_yaratable.a /tmp/osquery-sdk/lib/libosquery_tables_applications.a /tmp/osquery-sdk/lib/libosquery_tables_events_eventstable.a /tmp/osquery-sdk/lib/libosquery_tables_utility_utilitytable.a /tmp/osquery-sdk/lib/libosquery_tables_forensic.a /tmp/osquery-sdk/lib/libosquery_tables_sleuthkit_sleuthkittable.a /tmp/osquery-sdk/lib/libosquery_worker_ipc_tableipcjsonconverter.a /tmp/osquery-sdk/lib/libosquery_worker_ipc_linux_tablecontaineripc.a /tmp/osquery-sdk/lib/libosquery_worker_ipc_linux_tableipc.a /tmp/osquery-sdk/lib/libosquery_worker_ipc_posix_pipechannel.a /tmp/osquery-sdk/lib/libosquery_worker_logging_glog_logger.a /tmp/osquery-sdk/lib/libosquery_worker_system_linux_memory.a")

  # 扫描已安装的第三方库
  file(GLOB _installed_tp "${CMAKE_INSTALL_PREFIX}/lib/libthirdparty_*.a")
  foreach(lib ${_installed_tp})
    set(_pc_deps "${_pc_deps} ${lib}")
  endforeach()

  # OpenSSL
  foreach(lib libssl.a libcrypto.a)
    set(_p "${CMAKE_INSTALL_PREFIX}/lib/${lib}")
    if(EXISTS "${_p}")
      set(_pc_deps "${_pc_deps} ${_p}")
    endif()
  endforeach()

  # 系统库
  set(_pc_deps "${_pc_deps} -lm -lpthread -ldl -lresolv -lrt")

  # 构建 Libs 行
  string(STRIP "${_pc_deps}" _pc_deps)
  set(_libs_line "-L\${libdir} -Wl,--whole-archive  /tmp/osquery-sdk/lib/deps/libcodegen_native_tables.a /tmp/osquery-sdk/lib/deps/libcodegen_foreign_tables.a -Wl,--no-whole-archive -Wl,--allow-multiple-definition -Wl,--start-group -losquery_wrapper ${_pc_deps} /usr/local/osquery-toolchain/usr/lib/libc++.a /usr/local/osquery-toolchain/usr/lib/libc++abi.a -Wl,--end-group")

  # 写入 .pc 文件
  file(MAKE_DIRECTORY "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig")
  file(WRITE "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/osquery_wrapper.pc"
"prefix=/tmp/osquery-sdk
exec_prefix=\${prefix}
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: osquery_wrapper
Description: osquery SQL engine C wrapper for GhostTrace
Version: 
Requires:
Libs: ${_libs_line}
Cflags: -I\${includedir}
")

endif()

