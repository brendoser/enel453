
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity lap_register is
    Port (seconds : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          tenseconds : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          minutes : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          tenminutes : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
          clock : in STD_LOGIC;
          reset : in STD_LOGIC;
          load : in STD_LOGIC;
          l_seconds : out STD_LOGIC_VECTOR(3 DOWNTO 0);
          l_tenseconds : out STD_LOGIC_VECTOR(3 DOWNTO 0);
          l_minutes : out STD_LOGIC_VECTOR(3 DOWNTO 0);
          l_tenminutes : out STD_LOGIC_VECTOR(3 DOWNTO 0)
           );
end lap_register;

architecture Behavioral of lap_register is

begin


end Behavioral;
