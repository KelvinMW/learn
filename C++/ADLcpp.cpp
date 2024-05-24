#include <iostream>
//ADL reduces redundancy of repeating common standard library calls

namespace Text{
    void print(const std::string& message){
        std::cout<<message<<std::endl;
    }
}

int main(){
    std::string greeting = "Hello there";
    Text::print(greeting);
    return 0;
}