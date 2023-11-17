def linear_search(arr, target):
    for i in range(len(arr)):
        if arr[i] == target:
            return i
    return -1

# Example usage:
my_list = [64, 25, 12, 22, 11]
target_value = 12
result = linear_search(my_list, target_value)
if result != -1:
    print(f"Element {target_value} found at index {result}")
else:
    print(f"Element {target_value} not found in the array")
