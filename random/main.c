#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

int A[100];
int B[100];

extern void read(FILE* input, unsigned int n);
extern void func(unsigned int n);
extern void print(FILE* output, unsigned int n);
extern void random_read(unsigned int n);
extern int64_t time_dif(struct timespec timeA, struct timespec timeB);

int main(int argc, char** argv) {
    FILE *input, *output;
    unsigned int n;
    struct timespec start;
    struct timespec end;
    int64_t elapsed_ns;
    input = fopen(argv[1], "r");
    output = fopen(argv[2], "w");
    if (argc == 4) {
        scanf("%u", &n);
        random_read(n);
    }
    else {
        fscanf(input, "%u", &n);
        read(input, n);
    }
    clock_gettime(CLOCK_MONOTONIC, &start);
    func(n);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = time_dif(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);
    print(output, n);
    return 0;
}
