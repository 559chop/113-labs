#ifndef functions_hpp
#define functions_hpp

#include <iostream>
#include <fstream>
#include <cstring>
#include <cstdlib>
#include <cmath>
#include <vector>
#include <bitset>
#include "Cache.hpp"
using namespace std;

struct mcache
{
    bool validbit = false;
    bool history = false;
    int tag = 0;
    string data = "   ";
};

string memArr[128];
mcache mycache[8][2];
string regFile[8];

void readMemory();
void Decode2(string data,unsigned long & opcode,unsigned long & rs_register, unsigned long & rt_register, unsigned long & offset);
void Decode(string data, int counter);
void loadWord(int offset, int rs_register,int rt_register, string data);
void storeWord(int rt_register,int rs_register);
void calculations(int offset,int rs_reg, int & SetNum, int & tag);
void searching_cache(int SetNumber, int Tag ,int rt_register, string data);
void Load_to_cache(int SetNumber, int Tag,int blockNum,int register_number, string data);

#endif 
