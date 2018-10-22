library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity COUNTDOWN is

  Port (clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        cd_start : in STD_LOGIC;
        select_s : in STD_LOGIC;
        select_ts : in STD_LOGIC;
        select_m : in STD_LOGIC;
        select_tm : in STD_LOGIC;
        seconds : out STD_LOGIC_VECTOR(3 downto 0);
        tenseconds : out STD_LOGIC_VECTOR(3 downto 0);
        minutes : out STD_LOGIC_VECTOR(3 downto 0);
        tenminutes : out STD_LOGIC_VECTOR(3 downto 0)
         );
         
end COUNTDOWN;

architecture Behavioral of COUNTDOWN is

signal select_s_i, select_ts_i, select_m_i, select_tm_i : STD_LOGIC;
signal sec_en, tsec_en, min_en, tmin_en : STD_LOGIC;
signal onehz_zero_i, sec_zero_i, tsec_zero_i, min_zero_i : STD_LOGIC;

component upcounter is
   Generic (  period : integer:= 4;
              WIDTH  : integer:= 3
           );
      PORT ( clk    : in  STD_LOGIC;
             reset  : in  STD_LOGIC;
             enable : in  STD_LOGIC;
             zero   : out STD_LOGIC;
             value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
           );
end component;

component downcounter is
  Generic ( period: integer:= 4;       
            WIDTH  : integer:= 3
		  );
    PORT ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           zero   : out STD_LOGIC;
           value  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
         );
end component;

component low_to_high_detect is
  Port ( D : in STD_LOGIC;
         clk : in STD_LOGIC;
         pulse : out STD_LOGIC
         );
end component;


begin
    
   second_selector : low_to_high_detect
   PORT MAP ( clk => clk,
              D => select_s,
              pulse => select_s_i
             );  
             
   tensecond_selector : low_to_high_detect
   PORT MAP ( clk => clk,
              D => select_ts,
              pulse => select_ts_i
             );             
             
    minute_selector : low_to_high_detect
    PORT MAP ( clk => clk,
               D => select_m,
               pulse => select_m_i
              );

   tenminute_selector : low_to_high_detect
   PORT MAP ( clk => clk,
              D => select_tm,
              pulse => select_tm_i
             );              
    
   oneHzClock: upcounter
   generic map(
               period => (100000000),   -- divide by 100_000_000 to divide 100 MHz down to 1 Hz 
               WIDTH  => 28             -- 28 bits are required to hold the binary value of 101111101011110000100000000
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => cd_start,
               zero   => onehz_zero_i, -- this is a 1 Hz clock signal
               value  => open  -- Leave open since we won't display this value
            );

   singleSecondsClock: downcounter
   generic map(
               period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
               WIDTH  => 4
              )
   PORT MAP (
               clk    => clk,
               reset  => reset,
               enable => sec_en,
               zero   => sec_zero_i,
               value  => seconds -- binary value of seconds we decode to drive the 7-segment display        
            );
            
    tenSecondsClock : downcounter
    generic map (
                 period => (6), --Counts numbers between 0 and 5 --> that's 6 values!
                 WIDTH => 4     
                )
    PORT MAP (
                clk   => clk,
                reset => reset,
                enable => tsec_en,
                zero   => tsec_zero_i,
                value  => tenseconds
              );         
              
   singleMinutesClock: downcounter
   generic map(
                period => (10),   -- Counts numbers between 0 and 9 -> that's 10 values!
                WIDTH  => 4
              )
   PORT MAP (
                clk    => clk,
                reset  => reset,
                enable => min_en,
                zero   => min_zero_i,
                value  => minutes -- binary value of seconds we decode to drive the 7-segment display        
             );      
             
   tenMinutesClock : downcounter
   generic map (
                period => (6), --Counts numbers between 0 and 5 --> that's 6 values!
                WIDTH => 4     
                )
  PORT MAP (
               clk   => clk,
               reset => reset,
               enable => tmin_en,
               zero   => open,
               value  => tenminutes
            );         
            
   --internal combinational logic
   
   sec_en <= (select_s_i and not cd_start) or (onehz_zero_i and cd_start);         
   tsec_en <= (select_ts_i and not cd_start) or (sec_zero_i and cd_start);
   min_en <= (select_m_i and not cd_start) or (tsec_zero_i and cd_start);
   tmin_en <= (select_tm_i and not cd_start) or (min_zero_i and cd_start);
   
end Behavioral;
