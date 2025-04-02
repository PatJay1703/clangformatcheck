#include <iostream>
#include <vector>

#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

class Person {
private:
  string name;
  int age;

public:
  Person(string n, int a) : name(n), age(a){};
  void display() { cout << "Name: " << name << ", Age: " << age << endl; }
};

void sortNames(vector<Person> &people) {
  sort(people.begin(), people.end(),
       [](const Person &a, const Person &b) { return a.name < b.name; });
}

void foo(int x, int y) {
    std::vector<int> v;
    for (int i = 0; i < 10; i++) {
        v.push_back(i);
    }
    if (x == y) {
      std::cout << "x is greater than y" << std::endl;
    } else {
      std::cout << "y is greater than x" << std::endl;
    }
}

int main() {
  int a = 10, b = 20;
  foo(a, b);
  return 0;
  if(a==b){cout<<"this is same";}
  if (a == b)
    cout << "this is extra thing"
}
