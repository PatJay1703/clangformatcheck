#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

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

    return 0;
}

