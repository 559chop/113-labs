library ieee;
use ieee.std_logic_1164.all;

entity DECODER_2x4 is
port( sel1: in std_logic;
      sel2: in std_logic;
	  d1: out std_logic;
      d2: out std_logic;
      d3: out std_logic;
      d4: out std_logic
      );
end DECODER_2x4;

architecture struct of DECODER_2x4 is

   component AND_gate is
   port( x: in std_logic;
         y: in std_logic;
         z: out std_logic
        );
   end component;

   component NOT_gate is
   port( x: in std_logic;
         z: out std_logic
        );
   end component;
   

   signal t0: std_logic;  
   signal t1: std_logic; 
   signal t2: std_logic; 
   signal t3: std_logic; 
   
   
begin
   
	map_NOT_gate1:  NOT_gate port map (sel1, t0);          
	map_NOT_gate2:  NOT_gate port map (sel2, t1); 			
	map_NOT_gate3:  NOT_gate port map (sel1, t2);			
	map_NOT_gate4:  NOT_gate port map (sel2, t3);			
	
	
	map_AND_gate1: AND_gate port map (t0,t1,d1);  
	map_AND_gate2: AND_gate port map (t2, sel2, d2);   
	map_AND_gate3: AND_gate port map (sel1, t3, d3);   
	map_AND_gate4: AND_gate port map (sel1, sel2, d4);      
	
	
                                                             

end struct;
