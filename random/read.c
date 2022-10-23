#include <stdio.h>

extern int A[];
extern int B[];

void read(FILE *input, unsigned int n) {
    for (int i = 0; i < n; ++i) {
        fscanf(input, "%d", &A[i]);
    }
}