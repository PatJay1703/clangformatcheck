#include <iostream>

class textFileReader {  // violation: class name starts with lowercase
public:
    void OpenFile() {  // violation: function name starts with uppercase
        std::cout << "Opening file..." << std::endl;
    }
};

enum valueKind {  // violation: enum name starts with lowercase
    VALUE1,
    VALUE2
};

int Leader = 0;  // violation: variable name starts with uppercase

void Getitems() {  // violation: function name starts with uppercase
    std::cout << "Getting items..." << std::endl;
}

int main() {
    textFileReader reader;
    reader.OpenFile();
    Getitems();
    return 0;
}
