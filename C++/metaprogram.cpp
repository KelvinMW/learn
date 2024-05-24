#include <iostream>
template <int base, unsigned int exponent>
struct power
{
static const int halfvalue = power<base, exponent / 2>::value;
static const int value = halfvalue * halfvalue * power<base, exponent % 2>::value;
};
template <int base>
struct power<base, 0>
{
static const int value = 1;
static_assert(base != 0, "power<0, 0> is not allowed");
};
template <int base>
struct power<base, 1>
{
static const int value = base;
};
int main(){
    std::cout << power<0, 0>::value;
    std::cout<<""<<std::endl;
}