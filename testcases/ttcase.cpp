#include <iostream>
using namespace std;

#include <iostream>

class MyClass {
public:
MyClass(int x,int y) { this->x=x;this->y=y; }

void doSomething() 
{
    if (x > 0){ 
        std::cout << "x is positive" ;
    }
    else{
        std::cout << "x is non-positive";
    }

    if (y<10){doSomethingElse();}
    else{
        doAnotherThing();
    }
}

void doSomethingElse(){std::cout << "Doing something else";}

void doAnotherThing(){
std::cout << "Doing another thing";
}
private:
int x,y;
};

int main()
{
MyClass obj(10,5);
obj.doSomething();
return 0;
}

int calculateArea(int length, int width) {
    return length * width;
}


int main() {
    int length = 5;
    int width = 3;
    cout << "Area of rectangle: " << calculateArea(length, width) << endl;
    return 0;
}

