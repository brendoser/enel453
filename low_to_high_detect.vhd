library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity low_to_high_detect is
  Port ( D : in STD_LOGIC;
         clk : in STD_LOGIC;
         pulse : out STD_LOGIC
         );
end low_to_high_detect;

architecture Behavioral of low_to_high_detect is
    signal Q : STD_LOGIC;
begin
    process(clk)
        begin
            if(rising_edge(clk)) then
                Q <= D;
            end if;
     end process;
     pulse <= D and not Q;           

end Behavioral;
