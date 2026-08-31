/**
 * osquery CGO wrapper - C++ 实现
 *
 * 使用 osquery 的 query() API 执行 SQL 查询
 * 通过 C 接口暴露给 Go CGO
 */

#include "wrapper.h"

#include <cstring>
#include <iostream>
#include <mutex>
#include <sstream>
#include <string>
#include <vector>

// osquery 核心头文件
#include <osquery/core/core.h>
#include <osquery/core/flags.h>
#include <osquery/core/system.h>
#include <osquery/sql/sql.h>
#include <osquery/registry/registry_factory.h>

// 使用 osquery 的 Flag API 来设置 flags（避免 DECLARE 依赖问题）
#include <osquery/core/flags.h>

// 全局状态
static osquery::Initializer* g_init = nullptr;
static std::mutex g_query_mutex;
static osquery_log_callback_t g_log_callback = nullptr;
static osquery_event_callback_t g_event_callback = nullptr;

// JSON 字符串转义
static std::string escapeJson(const std::string& s) {
  std::string result;
  result.reserve(s.size() + 16);
  for (char c : s) {
    switch (c) {
      case '"':  result += "\\\""; break;
      case '\\': result += "\\\\"; break;
      case '\n': result += "\\n";  break;
      case '\r': result += "\\r";  break;
      case '\t': result += "\\t";  break;
      default:   result += c;
    }
  }
  return result;
}

// 配置解析：key=value\nkey=value 格式
static void applyConfig(const char* config) {
  if (config == nullptr || std::strlen(config) == 0) return;

  std::string s(config);
  size_t pos = 0;

  while (pos < s.size()) {
    // 找到行尾
    size_t eol = s.find('\n', pos);
    if (eol == std::string::npos) eol = s.size();

    // 解析 key=value
    std::string line = s.substr(pos, eol - pos);
    size_t eq = line.find('=');
    if (eq != std::string::npos) {
      std::string key = line.substr(0, eq);
      std::string value = line.substr(eq + 1);

      // 直接用 Flag::updateValue 设置
      osquery::Flag::updateValue(key, value);
    }

    pos = eol + 1;
  }
}

// QueryData → JSON
static char* toJson(const osquery::QueryData& rows) {
  std::ostringstream oss;
  oss << "[";
  for (size_t i = 0; i < rows.size(); ++i) {
    if (i > 0) oss << ",";
    oss << "{";
    size_t j = 0;
    for (const auto& kv : rows[i]) {
      if (j++ > 0) oss << ",";
      oss << "\"" << escapeJson(kv.first) << "\":\""
          << escapeJson(kv.second) << "\"";
    }
    oss << "}";
  }
  oss << "]";

  std::string s = oss.str();
  char* buf = new char[s.size() + 1];
  std::memcpy(buf, s.c_str(), s.size() + 1);
  return buf;
}



// ========== C 接口实现 ==========

extern "C" {

int osquery_init(const char* flags_json) {
  if (g_init != nullptr) return -1;

  try {
    int argc = 1;
    char arg0[] = "ghosttrace";
    char* argv[] = {arg0, nullptr};
    char** argv_ptr = argv;

    g_init = new osquery::Initializer(argc, argv_ptr, osquery::ToolType::TEST);

    // 默认配置
    std::string full_config = "disable_extensions=true\ndisable_watchdog=true";
    if (flags_json != nullptr && std::strlen(flags_json) > 0) {
      full_config += "\n";
      full_config += flags_json;
    }
    applyConfig(full_config.c_str());
    g_init->start();
    return 0;
  } catch (const std::exception& e) {
    std::cerr << "osquery_init failed: " << e.what() << std::endl;
    return -1;
  }
}

void osquery_set_log_callback(osquery_log_callback_t cb) {
  g_log_callback = cb;
}

void osquery_set_event_callback(osquery_event_callback_t cb) {
  g_event_callback = cb;
}

char* osquery_query(const char* sql) {
  if (g_init == nullptr || sql == nullptr) return nullptr;

  std::lock_guard<std::mutex> lock(g_query_mutex);

  try {
    osquery::QueryData results;
    auto status = osquery::query(sql, results);
    if (!status.ok()) {
      std::cerr << "osquery_query failed: " << status.getMessage() << std::endl;
      return nullptr;
    }
    return toJson(results);
  } catch (const std::exception& e) {
    std::cerr << "osquery_query exception: " << e.what() << std::endl;
    return nullptr;
  }
}

void osquery_free_result(char* result) {
  if (result) delete[] result;
}

const char* osquery_version() {
  return "5.12.0";
}

void osquery_shutdown() {
  try {
    if (g_init) {
      // Go 的 goroutine 可能在不同 OS 线程执行，导致线程 ID 不匹配
      // 如果当前线程不是初始化线程，用 std::async 在新线程中调用 shutdown
      // 但这不能解决问题，因为 osquery 检查的是主线程 ID
      //
      // 正确方案：直接调用 shutdown(0)，捕获异常后做手动清理
      try {
        g_init->shutdown(0);
      } catch (const std::runtime_error& e) {
        std::cerr << "osquery_shutdown runtime_error: " << e.what() << std::endl;
      } catch (const std::exception& e) {
        std::cerr << "osquery_shutdown exception: " << e.what() << std::endl;
      } catch (...) {
        std::cerr << "osquery_shutdown: unknown exception" << std::endl;
      }
      delete g_init;
      g_init = nullptr;
    }
    g_log_callback = nullptr;
    g_event_callback = nullptr;
  } catch (const std::exception& e) {
    std::cerr << "osquery_shutdown exception: " << e.what() << std::endl;
  } catch (...) {
    std::cerr << "osquery_shutdown: unknown exception" << std::endl;
  }
}

} // extern "C"
