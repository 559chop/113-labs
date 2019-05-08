#include "functions.hpp"



void loadToCache(int SetNumber,int Tag,int blockNum,int reg_number,string data)
{
    
    mycache[SetNumber][blockNum].tag = Tag;
    mycache[SetNumber][blockNum].data = data;
    regFile[reg_number] = mycache[SetNumber][blockNum].data;
    
    
    for(int k=0; k<8;k++){
        cout<<"  reg  ["<<k<<"] "<<regFile[k]<<endl;;
    }
    

    for(int i=0; i<8; i++) 
    {
        for(int j=0; j<2; j++) 
        {
            
            cout<<" Set ["<<i<<"]  Block ["<<j<<"]  "<<mycache[i][j].data<<endl;
            
        }
        cout<<endl;
    }
}

void searching_cache(int SetNumber, int Tag ,int rt_reg, string data )
{
    
    int reg_number = rt_reg - 16;
    
    if (mycache[SetNumber][0].validbit == true)
    {
        if(mycache[SetNumber][0].tag == Tag){
            cout<<" FOUND [HIT] "<<endl;
            loadToCache(SetNumber, Tag, 0, reg_number, mycache[SetNumber][0].data);
        }else{
            cout<<" NOT FOUND [MISS]"<<endl;
            loadToCache(SetNumber, Tag, 1, reg_number, data);
        }
        
    }else if (mycache[SetNumber][1].validbit == true){
        
        if(mycache[SetNumber][1].tag == Tag){
            
            cout<<" FOUND [HIT] "<<endl;
            loadToCache(SetNumber, Tag, 1, reg_number, mycache[SetNumber][1].data);
        }else{
            
            cout<<" NOT FOUND [MISS]"<<endl;
            loadToCache(SetNumber, Tag, 1, reg_number, data);
        }
        
    }else if (mycache[SetNumber][0].validbit == false){
        cout<< "NOT FOUND [MISS]"<<endl;
        int blockNum = 0;
        loadToCache(SetNumber,Tag,blockNum,reg_number,data);
        mycache[SetNumber][blockNum].validbit = true;
    }else if (mycache[SetNumber][1].validbit == false){
        cout<< "NOT FOUND [MISS]"<<endl;
        int blockNum = 1;
        loadToCache(SetNumber,Tag,blockNum,reg_number,data);
        mycache[SetNumber][blockNum].validbit = true;
        
    }
    
    
}

void Decode2(string data,unsigned long & opcode,unsigned long & rs_reg, unsigned long & rt_reg, unsigned long & offset)
{
    
    string opcode_temp, rs_reg_temp, rt_reg_temp, offset_temp;
    cout << endl
    << endl
    << endl;
    cout << "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" << endl;
    cout << "                                  DECODER 2                           " << endl;
    cout << "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" << endl<<endl;
    cout << "The size of data " << data.length() << endl<< endl;
    
    // if string length is 0 or exceed then exit the code
    if(data.length() == 0 ){
        cout << "NOTHING IN reg" <<endl<<endl;
        exit(0);
    }else if (data.length() >33  ){
        
        cout << "ERROR: EXCEED THE STRING LIMIT OF 32" <<endl<<endl;
        exit(0);
    }else
    {
        //decoding the string to opcode, rs reg ,rt reg and offset respectively
        
        for (int count = 0; count < 6; count++)
        {
            opcode_temp += data.at(count);
        }
        for (int count = 6; count < 11; count++)
        {
            rs_reg_temp += data.at(count);
        }
        for (int count = 11; count < 16; count++)
        {
            rt_reg_temp += data.at(count);
        }
        for (int count = 16; count < 32; count++)
        {
            offset_temp += data.at(count);
        }
        cout << "opcode"
        << " "
        << " rs "
        << "  "
        << " rt "
        << "     "
        << "  offset " << endl;
        cout << opcode_temp << " " << rs_reg_temp << " " << rt_reg_temp << " " << offset_temp << endl;
        
        
        // functions to  convert binary to decimal of Opcode, rs reg ,rt reg and offset respectively
        opcode = stoull(opcode_temp, 0, 2);
        rs_reg = stoull(rs_reg_temp, 0, 2);
        offset = stoull(offset_temp, 0, 2);
        rt_reg = stoull(rt_reg_temp, 0, 2);
        
        cout<< opcode << "       " << rs_reg<< "    " << rt_reg << "          " << offset<< endl
        << endl;
    }
}


void calculations(int offset,int rs_reg, int & SetNum, int & tag)
{
    long byteaddress, wordaddress;
    
    byteaddress = offset + rs_reg;        // Byte address
    wordaddress = byteaddress / 4;       // Word address
    
    SetNum = wordaddress % 8;          // Get the set number
    tag = wordaddress / 8;            // Get the tag value
    
}

void storeWord(int rt_reg, int rs_reg)
{
    
    unsigned long _opcode, _Rs_reg, _Rt_reg,_offset;
    int SetNumber , Tag , Memory_address;
    int reg_Number = rt_reg - 16;  // to get a CPU reg number
    string CPU_data;                         // string to store value of CPU reg
    
    
    cout << "------------- LOAD WORD --------------" << endl;
    
    CPU_data = regFile[reg_Number];   // storing value of CPU reg to string
    
    cout << " CPU reg Number = " << reg_Number<<" & CPU Regiter data is "<<CPU_data<< endl<< endl;
    
    Decode2(CPU_data,_opcode , _Rs_reg, _Rt_reg, _offset);
    
    cout<<"========================== Store Word ================================"<<endl<<endl;
    cout<<"RS reg "<<_Rs_reg<<"  RT reg "<<_Rt_reg<<" offset "<<_offset<<endl;
    
    calculations(_offset, rs_reg, SetNumber, Tag);
    
    cout<<"SetNumber = "<<SetNumber<<"   Tag = "<<Tag<<endl;
    
    searching_cache(SetNumber, Tag, _Rt_reg, CPU_data);
    
    Memory_address = (Tag * 8) + SetNumber;
    
    memArr[Memory_address] = CPU_data;
    cout<<" Memory Address "<<Memory_address<<endl;
    
    
    for(int k=0; k<128;k++){
        cout<<"  Memory  ["<<k<<"] "<<memArr[k]<<endl;;
    }    
}


// Function for load word
void loadWord(int offset,int rs_reg,int rt_reg,string data)
{
    int Set_Number, Tag_Value;
    
    cout << "------------- LOAD WORD --------------" << endl;

    calculations(offset, rs_reg, Set_Number, Tag_Value);
    
    cout<<"SET NUMBER   = "<<Set_Number<<endl;
    cout<<"TAG VALUE    = "<<Tag_Value<<endl;
    
    searching_cache(Set_Number,Tag_Value,rt_reg, data);
    
}

void Decode(string data, int counter)
{
    
    string opcode_temp, rs_reg_temp, rt_reg_temp, offset_temp;
    cout    << endl
            << endl
            << endl;
    cout << "------------- START READING FROM MEMORY "<< counter<<" --------------------" << endl;
    cout << "The size of data " << data.length() << endl<< endl;

        for (int count = 0; count < 6; count++)
        {
            opcode_temp += data.at(count);
        }
        for (int count = 6; count < 11; count++)
        {
            rs_reg_temp += data.at(count);
        }
        for (int count = 11; count < 16; count++)
        {
            rt_reg_temp += data.at(count);
        }
        for (int count = 16; count < 32; count++)
        {
            offset_temp += data.at(count);
        }
        cout << "opcode"
        << " "
        << " rs "
        << "  "
        << " rt "
        << "     "
        << "  offset " << endl;
        cout << opcode_temp << " " << rs_reg_temp << " " << rt_reg_temp << " " << offset_temp << endl;
        
        unsigned long long opcode = stoull(opcode_temp, 0, 2);
        unsigned long long rs_register = stoull(rs_reg_temp, 0, 2);
        unsigned long long offset = stoull(offset_temp, 0, 2);
        unsigned long long rt_register = stoull(rt_reg_temp, 0, 2);
        
        cout << opcode << "       " << rs_register<< "    " << rt_register << "          " << offset<< endl
        << endl;
\
        if (opcode == 35)
        {
            loadWord(offset,rs_register,rt_register,data); 
        }
        else if (opcode == 43)
        {
            storeWord(rt_register, rs_register);  
        }
}
