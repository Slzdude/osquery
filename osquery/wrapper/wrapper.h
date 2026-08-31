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

int osquery_init(const char* flags_json);
void osquery_set_log_callback(void (*callback)(int, const char*, int, const char*));
void osquery_set_event_callback(void (*callback)(const char*, const char*));
char* osquery_query(const char* sql);
void osquery_free_result(char* result);
const char* osquery_version(void);
void osquery_shutdown(void);

#ifdef __cplusplus
}
#endif

#endif
