#include "Cache.hpp"

Cache::Cache()
{
    this->mCache    = new MCache*[8];
    this->_memories     = new std::string[128];
    this->_registers    = new std::string[8];
    this->_sections     = new int[4];
    
    this->_currLine      = "";
    this->_victimBlock   = "";
    this->_byteAddress   = 0;
    this->_wordAddress   = 0;
    this->_memoryAddress = 0;
    this->_currIndex     = 0;
    this->_numSet        = 0;
    this->_numTag        = 0;
    this->_numRegister   = 0;
    this->_block         = 0;
    
    for (int i = 0; i < 8; ++i) {
        this->mCache[i] = new MCache[2];
    }
}

Cache::~Cache()
{
    for (int i = 0; i < 8; ++i) {
        delete this->mCache[i];
    }
    
    delete this->_sections;
    delete this->_registers;
    delete this->_memories;
    delete this->mCache;
}

void Cache::inputMemories()
{
    std::string data_;
    std::ifstream file_("input.txt");
    
    if (file_.is_open()) {
        for (std::string line; std::getline(file_, line); ++this->_currIndex) {
            this->_memories[this->_currIndex] = line;
            this->_currLine                   = line;
            this->decoder();
        }
        file_.close();
    }
    else {
        printf("Unable to open file.\n");
    }
}

void Cache::decoder()
{
    const int FOUR_ = 4;
    
    std::string tempRegister_[FOUR_] = {"", "", "", ""};
    int sectionRegister_[FOUR_]      = {6, 11, 16, 32};
    int currSection_                 = 0;
        
    for (int i = 0; i < FOUR_; ++i) {
        for (int j = currSection_; j < sectionRegister_[i]; ++j) {
            tempRegister_[i] += this->_currLine[j];
        }
        this->_sections[i] = (int)std::stoull(tempRegister_[i], 0, 2);
        currSection_ = sectionRegister_[i];
    }
    
    printf("====Current Index: %i==== \n", this->_currIndex);
    printf("Opcode: %i \n", this->_sections[0]);
    printf("RS Reg: %i \n", this->_sections[1]);
    printf("RT Reg: %i \n", this->_sections[2]);
    printf("Offset: %i \n\n", this->_sections[3]);
    
    this->whichOpcode();
}

void Cache::whichOpcode()
{
    int opCode_ = this->_sections[0];

    switch (opCode_) {
        case 35: {
            this->loadWord();
        } break;
            
        case 43: {
            this->storeWord();
        } break;
    }
}

void Cache::loadWord()
{
    this->_numRegister = this->_sections[2] - 16;
    
    this->_byteAddress = this->_sections[3] + this->_sections[1];
    this->_wordAddress = this->_byteAddress / 4;
    printf("Word Address: %i \n\n", (int)this->_wordAddress);
    
    this->_numSet  = (int)(this->_wordAddress % 8);
    this->_numTag  = (int)(this->_wordAddress / 8);
    
    printf("******LOAD_WORD******\n");
    printf("Set Number: %i \n", this->_numSet);
    printf("Set Tag: %i \n\n", this->_numTag);
    
    this->searchCache();
}

void Cache::storeWord()
{
    this->_numRegister = this->_sections[2] - 16;
    this->_currLine    = this->_registers[this->_numRegister];
    this->decoder();
    
    this->_byteAddress = this->_sections[3] + this->_sections[1];
    this->_wordAddress = this->_byteAddress / 4;
    printf("Word Address: %i \n\n", (int)this->_wordAddress);
    
    this->_numSet = (int)(this->_wordAddress % 8);
    this->_numTag = (int)(this->_wordAddress / 8);
    
    printf("******STORE_WORD******\n");
    printf("Set Number: %i \n", this->_numSet);
    printf("Set Tag: %i \n\n", this->_numTag);
    
    this->searchCache();
    
    this->_memoryAddress = (this->_numTag * 8) + this->_numSet;
    this->_memories[this->_memoryAddress] = this->_currLine;
}

void Cache::searchCache()
{
    if (this->mCache[this->_numSet][0]._isValidBit) {
        if(this->mCache[this->_numSet][0]._tag == this->_numTag) {
            this->_victimBlock = "HIT";
            this->_block = 0;
            this->loadCache();
        }
        else {
            this->_victimBlock = "MISS";
            this->_block = 1;
            this->loadCache();
        }
    }
    else if (this->mCache[this->_numSet][1]._isValidBit) {
        if(this->mCache[this->_numSet][1]._tag == this->_numTag) {
            this->_victimBlock = "HIT";
            this->_block = 1;
            this->loadCache();
        }
        else {
            this->_victimBlock = "MISS";
            this->_block = 1;
            this->loadCache();
        }
    }
    else if (!this->mCache[this->_numSet][0]._isValidBit) {
        this->_victimBlock = "MISS";
        this->_block = 0;
        this->mCache[this->_numSet][0]._isValidBit = true;
        this->loadCache();
        
    }
    else if (!this->mCache[this->_numSet][1]._isValidBit) {
        this->_victimBlock = "MISS";
        this->_block = 1;
        this->mCache[this->_numSet][1]._isValidBit = true;
        this->loadCache();
    }
    
    printf("Victim Block: %s \n\n", this->_victimBlock.c_str());
    
    printf("Memory Address: %i \n", (this->_numTag * 8) + this->_numSet);
    printf("Memory [%i]: %s \n", this->_currIndex, this->_memories[this->_currIndex].c_str());
    printf("====END==== \n\n");
}

void Cache::loadCache()
{
    this->mCache[this->_numSet][this->_block]._tag = this->_numTag;
    this->mCache[this->_numSet][this->_block]._data = this->_memories[this->_currIndex];
    this->_registers[this->_numRegister] = this->mCache[this->_numSet][this->_block]._data;
}
