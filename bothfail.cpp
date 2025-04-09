#include<iostream>
#include<vector>
#include<algorithm>

using namespace std;

class Person{
private:
    string name;
    int age;
public:
    Person(string n, int a): name(n), age(a){};
    void display() { cout << "Name: " << name << ", Age: " << age << endl; }
};

void sortNames(vector<Person> &people){
    sort(people.begin(), people.end(), [](const Person &a, const Person &b){
        return a.name < b.name;
    });
}

int sum(int a, int b) {
  if (a > b) {
      return a;
  }
  // Missing return statement for the case when a <= b
}
int main()
{
 



int main() {
    std::cout << sum(10, 5) << std::endl;
    return 0;
}

}

