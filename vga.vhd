library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity vga is

	port (clk   : in STD_LOGIC;
			hSync : out STD_LOGIC;
			vSync : out STD_LOGIC;
			RGB   : out STD_LOGIC_VECTOR (2 downto 0));

end vga;

architecture vga_arch of vga is

	signal clk25 : std_logic := '0';
	
	constant HD : integer := 639;
	constant HFP : integer := 16;
	constant HSP : integer := 96;
	constant HBP : integer := 48;
	
	constant VD : integer := 479;
	constant VFP : integer := 10;
	constant VSP : integer := 2;
	constant VBP : integer := 33;
	
	signal hPos : integer := 0;
	signal vPos : integer := 0;
	
	signal videoOn : std_logic := '0';

	begin
	
	clk_div : process(CLK)
	
	begin
	
		if(CLK'event and CLK = '1') then
		
			clk25 <= not clk25;
			
		end if;
	
	end process;
	
	--Horizontal Counter
	
	horizontal_position_counter : process(clk25)
	
	begin 
		
		if(CLK25'event and CLK25 = '1') then
		
			if(hPos = (HD + HFP + HSP + HBP)) then 
			
				hPos <= 0;
			
			else
			
				hPos <= hPos + 1;
			
			end if;
			
		end if;
	
	end process;
	
	--Vertical Counter
	
	vertical_position_counter : process(clk25, hPos)
	
	begin 
		
		if(CLK25'event and CLK25 = '1') then
		
			if(hPos = (HD + HFP + HSP + HBP)) then
		
				if(vPos = (VD + VFP + VSP + VBP)) then 
				
					VPos <= 0;
				
				else
				
					vPos <= vPos + 1;
					
				end if;
			
			end if;
			
		end if;
	
	end process;
	
	--horizontal sync
	
	horizontal_sync : process(clk25, hPos)
	
	begin 
	
		
		if(CLK25'event and CLK25 = '1') then
			
				if ((hPos <= (HD + HFP)) OR (hPos > (HD + HFP + HSP))) then
					
					hSync <= '1';
				
				else
				
					hSync <= '0';
			
			end if;
			
		end if;
	
	end process;
	
	--verticl sync 
	
	vertical_sync : process(clk25, vPos)
	
	begin 
	
		
			
		if(CLK25'event and CLK25 = '1') then
			
				if ((vPos <= (VD + VFP)) OR (vPos > (VD + VFP + VSP))) then
					
					vSync <= '1';
				
				else
				
					vSync <= '0';
			
			end if;
			
		end if;
	
	end process;
	
	--Check if video is on
	
	video_on : process(clk25, hPos, vPos)
	
	begin 
	
			
			if(CLK25'event and CLK25 = '1') then
		
				if (hPos <= HD and vPos <= VD) then
				
					videoOn <= '1';
				
				else
				
					videoOn <= '0';
			
			end if;
			
		end if;
	
	end process;

	--Draw somthing
	
	draw : process(clk25, hPos, vPos, videoOn)
	
	begin 
	
		
				
				if(CLK25'event and CLK25 = '1') then
				
					if (videoOn = '1') then
					
						if((hPos >= 10 and hPos <= 60)) then
						
							RGB <= "001";
							
						elsif((hPos >= 61 and hPos <= 111)) then
						
							RGB <= "010";
							
						elsif((hPos >= 112 and hPos <= 162)) then
						
							RGB <= "011";
							
						elsif((hPos >= 163 and hPos <= 213)) then
						
							RGB <= "100";
							
						elsif((hPos >= 214 and hPos <= 264)) then
						
							RGB <= "101";
							
						elsif((hPos >= 265 and hPos <= 315)) then
						
							RGB <= "110";
							
						elsif((hPos >= 316 and hPos <= 366)) then
						
							RGB <= "111";

						else
						
							RGB <= "000";
						
						end if;
					
					else
					
						RGB <= "000";
				
				end if;
				
			end if;
	
	end process;
	
	
end architecture;
