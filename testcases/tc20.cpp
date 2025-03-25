#include <iostream>

void foo(int x, int y)
{
    if(x>y){std::cout<<"x is greater than y"<<std::endl;}else{std::cout<<"y is greater than x"<<std::endl;} 
}


int main() {
  int a=10,b=20;
  foo(a,b);
    return 0;
}




