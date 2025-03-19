#include <iostream>

class MyClass {
public:
  MyClass(int a, int b):x(a), y(b){} 
  void display() {
    std::cout<<"Hello, world!"<<std::endl;
  }
private:
  int x,y;  
};

int main() {
  MyClass obj(1,2);  
  obj.display();
  return 0;
}

