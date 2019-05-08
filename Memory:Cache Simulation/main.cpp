// Thien Nguyen CSCI 113
#include <iostream>
#include <fstream>
#include <cstring>
#include "functions.cpp"
using namespace std;

int main()
{
    string mdata;
    int loop = 0;                          
    string line;                           
    ifstream myfile("input.txt");        
    while (!myfile.eof())                    
    {
        getline(myfile, line);             
        memArr[loop] = line;
        Decode(memArr[loop],loop);
        loop++;
    }
    
    myfile.close();    

    return 0;
}

