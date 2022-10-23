#include <time.h>
#include <stdint.h>

int64_t time_dif(struct timespec timeA,struct timespec timeB) {
    int64_t nsecA, nsecB;
    nsecA = timeA.tv_sec;
    nsecA *= 1000000000;
    nsecA += timeA.tv_nsec;
    nsecB = timeB.tv_sec;
    nsecB *= 1000000000;
    nsecB += timeB.tv_nsec;
    return nsecA - nsecB;
}
