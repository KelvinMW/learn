#include <iostream>
using namespace std;

int linearSearch(int arr[], int n, int target) {
    for (int i = 0; i < n; i++) {
        if (arr[i] == target) {
            return i;
        }
    }
    return -1;
}

int main() {
    int arr[] = {64, 25, 12, 22, 11};
    int targetValue = 12;
    int n = sizeof(arr) / sizeof(arr[0]);
    int result = linearSearch(arr, n, targetValue);
    if (result != -1) {
        cout << "Element " << targetValue << " found at index " << result << endl;
    } else {
        cout << "Element " << targetValue << " not found in the array" << endl;
    }
    return 0;
}
