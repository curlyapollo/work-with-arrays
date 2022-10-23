extern int A[];
extern int B[];

void func(unsigned int n) {
    int j = 0;
    for(unsigned int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            B[j] = A[i];
        } else {
            B[(n + i) / 2] = A[i];
            j++;
        }
    }
}
