#include <stdio.h>
#include <stdlib.h>

extern int A[];
extern int B[];

void random_read(unsigned int n) {
    srand(1);
    for (int i = 0; i < n; ++i) {
        A[i] = rand() % 100;
        printf("%d\n", A[i]);
    }
}
