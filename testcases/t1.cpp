#include <iostream>
using namespace std;
void foo(vector<int>& vec)
{
for(int i=0;i<vec.size();i++)
{
if(vec[i]%2==0)
{
cout<<vec[i]<<" is even"<<endl;
}
else
{
cout<<vec[i]<<" is odd"<<endl;
}
}
}
int main(){
int x=  42;
   if(x>0){
cout<<"Hello, World!"<<endl;
   }
return 0;}

