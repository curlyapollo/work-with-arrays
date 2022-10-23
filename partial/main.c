#include <stdio.h>

int A[100];
int B[100];

extern void read(FILE* input, unsigned int n);
extern void func(unsigned int n);
extern void print(FILE* output, unsigned int n);

int main(int argc, char** argv) {
    FILE *input, *output;
    unsigned int n;
    input = fopen(argv[1], "r");
    output = fopen(argv[2], "w");
    fscanf(input, "%u", &n);
    read(input, n);
    func(n);
    print(output, n);
    return 0;
}
