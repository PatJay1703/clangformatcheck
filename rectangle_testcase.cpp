#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

#include<iostream>
using namespace std;

class Employee{
private:
    string name;
    int age;
    double salary;
public:
    Employee(string n, int a, double s){
        name=n;
        age=a;
        salary=s;
    }
    
    void displayInfo(){
        cout<<"Employee Name: "<<name<<endl;
        cout<<"Employee Age: "<<age<<endl;
        cout<<"Employee Salary: "<<salary<<endl;
    }
    
    double getSalary(){
        return salary;
    }
};

class Manager: public Employee{
private:
    int teamSize;
public:
    Manager(string n, int a, double s, int t): Employee(n,a,s){
        teamSize=t;
    }

    void displayInfo(){
        Employee::displayInfo();
        cout<<"Team Size: "<<teamSize<<endl;
    }

    void setTeamSize(int size){
        teamSize=size;
    }

    int getTeamSize(){
        return teamSize;
    }
};
double circleArea(double radius) {
    return M_PI * radius * radius;
}

double rectanglePerimeter(double length, double width) {
    return 2 * (length + width);
}

int sumVector(const vector<int>& vec) {
    return accumulate(vec.begin(), vec.end(), 0);
}

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= sqrt(n); ++i) {
        if (n % i == 0) return false;
    }
    return true;
}

int main() {
    double radius = 5.0;
    cout << "Circle area (radius " << radius << "): " << circleArea(radius) << endl;

    double length = 10.0, width = 4.0;
    cout << "Rectangle perimeter (length " << length << ", width " << width << "): " << rectanglePerimeter(length, width) << endl;

    vector<int> vec = {1, 2, 3, 4, 5, 6};
    cout << "Sum of vector elements: " << sumVector(vec) << endl;

    vector<int> testNumbers = {1, 2, 3, 4, 5, 16, 17};
    for (int num : testNumbers) {
        cout << num << " is " << (isPrime(num) ? "prime" : "not prime") << endl;
    }
    

    int x=5,y=10;cout<<x+y<<endl;return 0;}

}

