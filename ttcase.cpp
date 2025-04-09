#include <iostream>
#include <algorithm>
using namespace std;

int calculateArea(int length, int width) {
    return length * width;
}
int calculateArea(int L, int W) {  
    return L*W;  
}

int main() {
    int length = 5;
    int width = 3;
    cout << "Area of rectangle: " << calculateArea(length, width) << endl;
    return 0;
}

