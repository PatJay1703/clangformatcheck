 #include<iostream>
#include<vector>

 void processVector(std::vector<int> v){for(int i=0;i<v.size();i++)
   {std::cout<< v[i]<<std::endl;}}

int main(){
int *ptr=new int(10);// Memory leak: No delete
int x; // Unused variable

 std::vector<int> vec={1,2,3,4,5};
processVector(vec);
 return 0;}

