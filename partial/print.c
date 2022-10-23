#include <stdio.h>

extern int A[];
extern int B[];

void print(FILE* output, unsigned int n) {
    for (int i = 0; i < n; ++i) {
        fprintf(output, "%d\n", B[i]);
    }
}