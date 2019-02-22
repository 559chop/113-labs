library ieee;
use ieee.std_logic_1164.all;

entity MUX_gate is
port( a: in std_logic;
      b: in std_logic;
      sel: in std_logic;
      z:  out std_logic
      );
end MUX_gate;

architecture struct of MUX_gate is

   --use previously designed subcomponents
   component AND_gate is
   port( x: in std_logic;
         y: in std_logic;
         z: out std_logic
        );
   end component;

   component OR_gate is
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

   signal temp1: std_logic; --to store the output of the AND gate
   signal temp2: std_logic; --to store the output of the AND gate
   signal notSel: std_logic; --to store the output of the AND gate

begin
   
   --map signals of the outer component to subcomponents - idea of parameter passing
   map_notSel: NOT_gate port map(sel,notSel);
   map_AND_gate: AND_gate port map (a, notSel, temp1); --now, temp1 holds the output of the AND
   map_AND2_gate: AND_gate port map (b, sel, temp2); --now, temp1 holds the output of the AND
   map_OR_gate:  OR_gate port map (temp1, temp2, z); 
end struct;
