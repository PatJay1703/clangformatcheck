#include <iostream>
#include <vector>

void foo(int x, int y) {
    std::vector<int> v;
    for (int i = 0; i < 10; i++) {
        v.push_back(i);
    }
    if (x>y) {std::cout << "x is greater than y" << std::endl;} else {std::cout << "y is greater than x" << std::endl;}
}

int main() {int a=10,b=20;foo(a,b);return 0;}

