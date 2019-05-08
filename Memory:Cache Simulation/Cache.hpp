#ifndef Cache_hpp
#define Cache_hpp

#include <fstream>
#include <bitset>
#include <string>
#include <stdio.h>
#include <cstdlib>
#include <vector>
#include <cmath>
#include <array>

struct MCache
{
    std::string _data;
    int         _tag;
    bool        _isValidBit;
};

class Cache
{
    public:
        Cache();
        ~Cache();

        void inputMemories();
        void decoder();
        void whichOpcode();
        void loadWord();
        void storeWord();
        void searchCache();
        void loadCache();
    
    private:
        MCache**     _mainCache;
        std::string* _memories;
        std::string* _registers;
        int*         _sections;
    
        std::string _currLine;
        std::string _victimBlock;
        long        _byteAddress;
        long        _wordAddress;
        int         _memoryAddress;
        int         _currIndex;
        int         _numSet;
        int         _numTag;
        int         _numRegister;
        int         _block;
};

#endif 
