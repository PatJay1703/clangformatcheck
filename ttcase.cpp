#include <iostream>
using namespace std;

int calculateArea(int length, int width) {
    return length * width;
}

int main() {
    int length = 5;
    int width = 3;
    cout << "Area of rectangle: " << calculateArea(length, width) << endl;
    return 0;
}

