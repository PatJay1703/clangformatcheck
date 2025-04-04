#include <iostream>

// Class with missing documentation
class TextFileReader {
public:
    void OpenFile() {  // Function name starts with uppercase (violation)
        std::cout << "Opening file..." << std::endl;
    }
};

enum valueKind {  // Enum name starts with lowercase (violation)
    VALUE1,
    VALUE2,
    VAULU3,
};

int Leader = 0;  // Variable name starts with uppercase (violation)

void Getitems() {  // Function name starts with uppercase (violation)
    std::cout << "Getting items..." << std::endl;
}

int main() {
    TextFileReader reader;
    reader.OpenFile();
    Getitems();
    return 0;
}
