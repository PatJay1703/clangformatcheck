#include <iostream>
using namespace std;

class person{
int age;
string name;
public:
person(string n, int a){name=n;age=a;}
void setName(string n){name=n;}
void setAge(int a){age=a;}
int getAge(){return age;}
string getName(){return name;}
void display(){
cout<<"Name: "<<name<<endl;
cout<<"Age: "<<age<<endl;
}
};
class person1{
    int age;
    string name;
    public:
    person(string n, int a){name=n;age=a;}
    void setName(string n){name=n;}
    void setAge(int a){age=a;}
    int getAge(){return age;}
    string getName(){return name;}
    void display(){
    cout<<"Name: "<<name<<endl;
    cout<<"Age: "<<age<<endl;
    }
    };

class car{
public:
string model;
int year;
car(string m, int y){model=m;year=y;}
void setModel(string m){model=m;}
void setYear(int y){year=y;}
string getModel(){return model;}
int getYear(){return year;}
void show(){
cout<<"Model: "<<model<<endl;
cout<<"Year: "<<year<<endl;
}
};

int main(){
person p1("John", 25);
p1.display();
person p2("Anna", 22);
p2.display();
car c1("Tesla", 2022);
c1.show();
car c2("BMW", 2021);
c2.show();
return 0;
}

