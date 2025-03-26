#include <iostream>
#include <vector>
#include "llvm/IR/Function.h"

namespace llvm {

class foo {
public:
  // Missing documentation, this is just a random class.
  foo(int val) : x(val) {}

  void bar(int x) {
    // No explanation of this method.
    if(x > 10)
      std::cout << "X is greater than 10." << std::endl;
    else {
      // Missing comments
      x = 0;
      return;
    }
  }

private:
  int x; // Not properly named variable
};

} // llvm

namespace {

int myVar = 100;  // global variable inside anonymous namespace

} // namespace

void badFunction() {
  // Code violating multiple standards:
  std::vector<int> vec;
  for (int i = 0; i != vec.size(); ++i) {
    if (vec[i] < 5) {
      vec.push_back(42);  // Modifying a vector while iterating it.
    }
  }

  if (myVar == 100)  // unnecessary 'else' after return
    return;
  else
    std::cout << "This should never happen!" << std::endl;

  // Using the wrong increment style
  for (int i = 0; i < 10; i++) {  // Post-increment should be pre-increment
    std::cout << i << std::endl;
  }

  // Misusing 'using namespace' in header file
  using namespace llvm;

  // Inefficient loop - calling end() every iteration
  for (auto i = vec.begin(); i != vec.end(); ++i) {
    std::cout << *i << std::endl;  // Inefficient due to repeated calls to end()
  }

  // Braces should not be omitted for clarity
  if (myVar == 100)
    std::cout << "X is 100";  // Missing braces makes it unclear what is happening
}

int main() {
  foo f(5);  // Missing function documentation
  f.bar(15);
  badFunction();
  return 0;
}

