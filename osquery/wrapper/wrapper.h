#ifndef OSQUERY_WRAPPER_H
#define OSQUERY_WRAPPER_H

/**
 * osquery CGO wrapper - 纯 C 接口
 *
 * 所有 C++ 实现细节隐藏在 wrapper.cpp 中
 * Go CGO 只需要这个头文件
 *
 * Windows: 编译为 DLL，通过 LoadLibrary/GetProcAddress 加载
 * Linux/macOS: 编译为静态库，通过 CGO 直接链接
 */

// Windows DLL 导出/导入宏
#if defined(_WIN32) || defined(_WIN64)
  #ifdef OSQUERY_WRAPPER_EXPORTS
    #define OSQUERY_API __declspec(dllexport)
  #else
    #define OSQUERY_API __declspec(dllimport)
  #endif
#else
  #define OSQUERY_API
#endif

#ifdef __cplusplus
extern "C" {
#endif

// 回调函数类型
typedef void (*osquery_log_callback_t)(int severity, const char* file, int line, const char* message);
typedef void (*osquery_event_callback_t)(const char* event_type, const char* json_data);

OSQUERY_API int osquery_init(const char* flags_json);
OSQUERY_API void osquery_set_log_callback(osquery_log_callback_t callback);
OSQUERY_API void osquery_set_event_callback(osquery_event_callback_t callback);

// 查询接口：成功返回 JSON 字符串，失败返回 NULL
// err_buf: 错误信息缓冲区（由调用者分配），失败时写入错误描述，成功时写入空字符串
// err_buf_size: 缓冲区大小
OSQUERY_API char* osquery_query(const char* sql, char* err_buf, int err_buf_size);

OSQUERY_API void osquery_free_result(char* result);
OSQUERY_API const char* osquery_version(void);
OSQUERY_API void osquery_shutdown(void);

#ifdef __cplusplus
}
#endif

#endif
