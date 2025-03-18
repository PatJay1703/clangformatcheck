#include <iostream>
using namespace std;
#define MACRO 10   // Bad practice: Avoid macros for constants

class test  // Class name should be PascalCase (Test)
{ 
    public: 
    int a,b;   // Bad practice: No access specifiers, no naming convention
    test(){ a=1; b=2;}  // No indentation, initialization in constructor body

    void foo (int x, int y ){ cout << x+y;}  // No spaces, no proper indentation
};

int main ( ) { int x= 5,y = 10 ; test t; t.foo( x ,y); return 0; } // Everything is crammed, bad spacing
