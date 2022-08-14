#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "err.h"
#include "sys/mman.h"

void err(int eval, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    fprintf(stderr, "ERROR: ");
    vfprintf(stderr, fmt, args);
    va_end(args);
    exit(eval);
}

void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset) {
    (void)addr, (void)prot, (void)flags;
    addr = malloc(length);
    if (!addr) { return addr; }
    lseek(fd, offset, SEEK_SET);
    read(fd, addr, length);
    return addr;
}

int munmap(void *addr, size_t length) {
    (void)length;
    free(addr);
    return 0;
}

char *strndup(const char *s, int n) {
    char *ptr;
    int m = (int)strlen(s);
    if (n < m) { n = m; }
    ptr = malloc(n + 1);
    if (!ptr) { return ptr; }
    memcpy(ptr, s, n);
    ptr[n] = '\0';
    return ptr;
}
