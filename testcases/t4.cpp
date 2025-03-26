#include <iostream>
#include <vector>

namespace llvm {

    // This is a poorly named class without a documentation comment
    class foo {
    public:
        foo(int val) : x(val) {}   // No comment explaining the constructor
        // Missing method documentation
        void bar(int val) { 
            std::cout << "Value: " << val << std::endl;
            if (val > 10) std::cout << "Greater than 10" << std::endl;
        }
    private:
        int x;  // Not a descriptive variable name
    };

} // End of llvm namespace

namespace {   // Unnecessary anonymous namespace

    int unused_var = 10;   // Declaring an unused variable

    // Unnecessary method without any docstring
    void exampleFunction() {  
        std::cout << "This is an example." << std::endl;
    }

} // End of anonymous namespace

int main() {
    // Unnecessary single-line if statement, no braces, bad readability
    int a = 10;
    if (a == 10) std::cout << "a is 10" << std::endl;

    // Pre-increment is preferred over post-increment
    for (int i = 0; i < 10; i++) {  // Wrong increment style (should be ++i)
        std::cout << i << std::endl;
    }

    std::vector<int> vec = {1, 2, 3};
    for (int i = 0; i != vec.size(); i++) {  // Inefficient, `end()` should be evaluated once
        std::cout << vec[i] << std::endl;
    }

    // Braces should be used with conditionals for clarity
    if (a == 10)
        std::cout << "a is still 10" << std::endl;

    // Improper usage of 'using namespace'
    using namespace llvm;
    foo obj(42); // Using `foo` without a proper namespace qualification
    obj.bar(20);

    // Class `foo` lacks documentation
    foo anotherObj(5);

    return 0;
}

