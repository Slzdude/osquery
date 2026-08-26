#ifndef OSQUERY_WRAPPER_H
#define OSQUERY_WRAPPER_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * osquery CGO wrapper - 纯 C 接口
 *
 * 所有 C++ 实现细节隐藏在 wrapper.cpp 中
 * Go CGO 只需要这个头文件
 */

// 跨平台符号导出
#if defined(_WIN32) || defined(__CYGWIN__)
  #ifdef OSQUERY_WRAPPER_EXPORTS
    #define WRAPPER_API __declspec(dllexport)
  #else
    #define WRAPPER_API __declspec(dllimport)
  #endif
#elif defined(__GNUC__) && __GNUC__ >= 4
  #define WRAPPER_API __attribute__((visibility("default")))
#else
  #define WRAPPER_API
#endif

// 日志回调函数类型
typedef void (*osquery_log_callback_t)(
    int severity,
    const char* file,
    int line,
    const char* message
);

// 事件回调函数类型
typedef void (*osquery_event_callback_t)(
    const char* event_type,
    const char* json_data
);

WRAPPER_API int osquery_init(const char* flags_json);
WRAPPER_API void osquery_set_log_callback(osquery_log_callback_t callback);
WRAPPER_API void osquery_set_event_callback(osquery_event_callback_t callback);
WRAPPER_API char* osquery_query(const char* sql);
WRAPPER_API void osquery_free_result(char* result);
WRAPPER_API const char* osquery_version(void);
WRAPPER_API void osquery_shutdown(void);

#ifdef __cplusplus
}
#endif

#endif
