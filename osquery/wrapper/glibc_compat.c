// glibc/musl 兼容层
// 提供旧版 glibc 中存在但新版已移除的函数
// 以及 libudev 内部函数存根
#include <stdlib.h>
#include <errno.h>
#include <stddef.h>
#include <sys/stat.h>

// glibc 2.34+ 移除了 __secure_getenv
char *__secure_getenv(const char *name) {
    return getenv(name);
}

// glibc 2.30+ 移除了 sysctl（osquery sysctl_utils.cpp 使用）
int sysctl(int *name, int namelen, void *oldp, size_t *oldlenp, void *newp, size_t newlen) {
    errno = ENOSYS;
    return -1;
}

// libudev 内部函数（libudev-device-private.c 引用）
int util_create_path(const char *path) {
    struct stat st;
    if (stat(path, &st) == 0) return 0;
    return mkdir(path, 0755);
}
