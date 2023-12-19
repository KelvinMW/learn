#include <iostream>

using namespace std;

typedef struct
{
  int SquareFeet;     // The square footage of the house
  int NumBedrooms;    // The number of bedrooms in the house
  int NumBaths;       // The number of bathrooms in the house
} House;

int main(int argc, char * argv[]){
  byte *pBkgndColor = (byte *)53281;
  *pBkgndColor = 0;   // Set the background color to black
  return 0;
}

/**
 * @brief Allocates memory of the given size.
 * 
 * @param cbSize The size of memory to allocate.
 * @return A pointer to the allocated memory.
 */
void MyAlloc(size_t cbSize)
{
  return malloc(cbSize);
}

/**
 * @brief Calculates the price of a house based on its attributes.
 * 
 * @param pHouse A pointer to the House structure.
 * @return The calculated price of the house.
 */
void GetHousePrice(House * pHouse)
{
  return 100000 + pHouse->SquareFeet * 100 + pHouse->NumBedrooms * 1000 + pHouse->NumBaths * 5000;
}

/**
 * @brief Builds a new house and calculates its price.
 */
void BuildNewHouse()
{
  House * pHouse = (House *)MyAlloc(sizeof(House));   // Allocate memory for a new House structure
  cout << GetHousePrice(pHouse) << endl;              // Calculate and print the price of the house
}