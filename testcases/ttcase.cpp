#include <iostream>
using namespace std;
#include <iostream>

class exampleClass {
public:
    exampleClass() : ExampleVariable(0) {}

    void OpenFile() {
        std::cout << "File opened!" << std::endl;
    }

    int ExampleVariable;
};

enum valueKind {
    VK_Argument,
    VK_BasicBlock
};


int calculateArea(int length, int width) {
    return length * width;
}
int multiply( int a ,int b ){ if(a==0||b==0){return 0;}else{return a*b;}}


int main() {
    int length = 5;
    int width = 3;
    cout << "Area of rectangle: " << calculateArea(length, width) << endl;
    return 0;
}

