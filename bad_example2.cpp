#include<algorithm>
#include <iostream>
using namespace std;
void checkNumber(int num) {
  if (num > 0) {
      std::cout << "Positive" << std::endl;
      return;
  } else {  // This else is unnecessary after the return
      std::cout << "Non-positive" << std::endl;
  }
}
int main() {
  int a = 10;
  int b = 20;
  if (a < b) {
    cout << "A is smaller than B" << endl;
  } else {
    cout << "B is smaller than A" << endl;
  }
  return 0;
}
