#include <stdio.h>
typedef struct {
    int first, second;
} pair_t;
void g(int *, pair_t);
int main(void) {
    int arr[2] = {11, 22};
    pair_t pair = {33, 44};
    g(arr, pair);
    printf("%d %d %d\n", arr[0], pair.first, pair.second);
    return 0;
}
void g(int *arr, pair_t pair) {
    *arr = 55;
    pair.first = 66;
    pair.second = 77;
}