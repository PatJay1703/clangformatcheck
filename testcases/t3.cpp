#include <iostream>
#include <vector>

using namespace std;  // This violates the LLVM coding standard

namespace llvm {

    // This is a poorly named class without a documentation comment
    class foo {
    public:
        foo(int val) : x(val) {}   // No comment explaining the constructor
        // Missing method documentation
        void bar(int val) { 
            cout << "Value: " << val << endl;
            if (val > 10) cout << "Greater than 10" << endl;
        }
    private:
        int x;  // Not a descriptive variable name
    };

} // End of llvm namespace

namespace {   // Unnecessary anonymous namespace

    int unused_var = 10;   // Declaring an unused variable

    // Unnecessary method without any docstring
    void exampleFunction() {  
        cout << "This is an example." << endl;
    }

} // End of anonymous namespace

int main() {
    // Unnecessary single-line if statement, no braces, bad readability
    int a = 10;
    if (a == 10) cout << "a is 10" << endl;

    // Pre-increment is preferred over post-increment
    for (int i = 0; i < 10; i++) {  // Wrong increment style (should be ++i)
        cout << i << endl;
    }

    vector<int> vec = {1, 2, 3};
    for (int i = 0; i != vec.size(); i++) {  // Inefficient, `end()` should be evaluated once
        cout << vec[i] << endl;
    }

    // Braces should be used with conditionals for clarity
    if (a == 10)
        cout << "a is still 10" << endl;

    // Improper usage of 'using namespace'
    // This violates LLVM coding standards, as it pollutes the global namespace
    foo obj(42); // Using `foo` without a proper namespace qualification
    obj.bar(20);

    // Class `foo` lacks documentation
    foo anotherObj(5);

    return 0;
}

