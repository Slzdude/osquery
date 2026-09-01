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
 *
 * 编译为静态库，由 Agent 通过 CGO 直接链接
 */

// 回调函数类型
typedef void (*osquery_log_callback_t)(int severity, const char* file, int line, const char* message);
typedef void (*osquery_event_callback_t)(const char* event_type, const char* json_data);

int osquery_init(const char* flags_json);
void osquery_set_log_callback(osquery_log_callback_t callback);
void osquery_set_event_callback(osquery_event_callback_t callback);

// 查询接口：成功返回 JSON 字符串，失败返回 NULL
// err_buf: 错误信息缓冲区（由调用者分配），失败时写入错误描述，成功时写入空字符串
// err_buf_size: 缓冲区大小
char* osquery_query(const char* sql, char* err_buf, int err_buf_size);

void osquery_free_result(char* result);
const char* osquery_version(void);
void osquery_shutdown(void);

#ifdef __cplusplus
}
#endif

#endif
