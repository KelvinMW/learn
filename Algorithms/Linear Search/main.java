public class LinearSearch {
    public static int linearSearch(int arr[], int target) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return i;
            }
        }
        return -1;
    }

    public static void main(String args[]) {
        int arr[] = {64, 25, 12, 22, 11};
        int targetValue = 12;
        int result = linearSearch(arr, targetValue);
        if (result != -1) {
            System.out.println("Element " + targetValue + " found at index " + result);
        } else {
            System.out.println("Element " + targetValue + " not found in the array");
        }
    }
}
