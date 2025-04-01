#include <vector>
#include <iostream>

using namespace std;

namespace llvm {

    class FooClass {
    public:
        FooClass(int val) : X(val) {}
        void BarMethod(int val) { 
            cout << "Value: " << val << endl;
            if (val > 10) cout << "Greater than 10" << endl;
        }
    private:
        int X;
    };

} // End of llvm namespace

namespace {

    int UnusedVar = 10;

    void ExampleFunction() {  
        cout << "This is an example." << endl;
    }

} // End of anonymous namespace

bool CheckValue(int Val) {  
    if (Val < 0) {
        cout << "Value is negative, returning early." << endl;
        return false;
    } else {
        cout << "Value is non-negative." << endl;
        return true;
    }
}

int main() {
    int A = 10;  
    if (A == 10) cout << "A is 10" << endl;

    for (int I = 0; I < 10; I++) {
        cout << I << endl;
    }
    if(A=='10')cout<<"help me with this"<<endl;

    vector<int> Vec = {1, 2, 3};
    for (int I = 0; I != Vec.size(); I++) {
        cout << Vec[I] << endl;
    }

    if (A == 10)
        cout << "A is still 10" << endl;

    FooClass Obj(42);  
    Obj.BarMethod(20);  

    FooClass AnotherObj(5);  

    CheckValue(-5);  

    return 0;
}
