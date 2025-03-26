#include<iostream>
#include<vector>
#include<algorithm>
#include<vector>
using namespace std;

class Person{
private:
    string name;
    int age;
public:
    Person(string n, int a): name(n), age(a){};
    void display() { cout << "Namee: " << name << ", Age: " << age << endl; }
};

void sortNames(vector<Person> &people){
    sort(people.begin(), people.end(), [](const Person &a, const Person &b){
        return a.name < b.name;
    });
}

int main()
{
  vector<Person> people;
  people.push_back(Person("John", 30));
  people.push_back(Person("Jane", 25));
  people.push_back(Person("Mike", 35));
  people.push_back(Person("Alice", 28));
  
  sortNames(people);
  
  for(auto &p: people)
  {
    p.display();
  }
  
  int x= 10,y=20,z=30;
  if(x>y&&y<z){cout<<"x is greater than y and y is less than z\n";} else {cout<<"Condition failed\n";}

  // This part below has some issues that would fail clang-tidy
  int largeArray[10000];
  for(int i = 0; i < 10000; ++i) {largeArray[i]=i;}
  
  // Some inline code to test failure
  if(x==y){ cout<<"Equal"; return 0;}
  return 0;
}


