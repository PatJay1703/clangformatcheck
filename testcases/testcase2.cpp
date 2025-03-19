#include <iostream>

class MyClass {
public:
  MyClass(int a, int b):x(a), y(b){} 
  void display() {
    std::cout<<"Hello,,,, world!"<<std::endl;
  }
private:
  int   x,y,  z,q,  r;  
};

int main() {
  MyClass obj(1,2);  
  obj.display();
  return 0;
}

