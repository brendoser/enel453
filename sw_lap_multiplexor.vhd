library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sw_lap_multiplexor is
    Port (seconds : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          tenseconds : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          minutes : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          tenminutes : in STD_LOGIC_VECTOR(3 DOWNTO 0); 
          l_seconds : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          l_tenseconds : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          l_minutes : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          l_tenminutes : in STD_LOGIC_VECTOR(3 DOWNTO 0);
          selector : in STD_LOGIC;
          m_seconds : out STD_LOGIC_VECTOR(3 DOWNTO 0);
          m_tenseconds : out STD_LOGIC_VECTOR(3 DOWNTO 0);
          m_minutes : out STD_LOGIC_VECTOR(3 DOWNTO 0);
          m_tenminutes : out STD_LOGIC_VECTOR(3 DOWNTO 0)
          );
end sw_lap_multiplexor;

architecture Behavioral of sw_lap_multiplexor is

begin
    with selector select
       m_seconds <= seconds when '0',
                    l_seconds when '1';
    with selector select                
       m_tenseconds <= tenseconds when '0',
                       l_tenseconds when '1';
    with selector select  
       m_minutes <= minutes when '0',
                    l_minutes when '1';
    with selector select                 
       m_tenminutes <= tenminutes when '0',
                       l_tenminutes when '1';
                       
                       
end Behavioral;
