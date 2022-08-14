#include <sys/types.h>

#define MAP_FAILED NULL

#define MAP_SHARED  1
#define MAP_PRIVATE 2

#define PROT_READ  1
#define PROT_WRITE 2

void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset);
int munmap(void *addr, size_t length);
