#include<stdio.h>

unsigned int n;
int A[100];
int B[100];

void read() {
	scanf("%u", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%d", &A[i]);
	}
}

void print() {
	for (int i = 0; i < n; ++i) {
		  printf("%d\n", B[i]);
  }
}

void func() {
    int j = 0;
    for(size_t i = 0; i <= n; i++) {
        if (i % 2 == 0) {
            B[j] = A[i];
        } else {
            B[(n + i) / 2] = A[i];
            j++;
        }
    }
}

int main(void) {
    read();
    func();
    print();
    return 0;
}


