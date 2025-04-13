#include <iostream>
using namespace std;
#include<iostream>
using namespace std;
class MyClass{
public:
    int add(int a,int b){return a+b;}
  void sayHello(){cout<<"Hello"<<endl;}
  int multiply(int a,int b){return a*b;}
};
int main(){
int x=5,y=10;
MyClass obj;
cout<<"Add: "<<obj.add(x,y)<<endl;
cout<<"Multiply: "<<obj.multiply(x,y)<<endl;
obj.sayHello();
return 0;}

