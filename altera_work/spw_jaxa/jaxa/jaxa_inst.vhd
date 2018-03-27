	component jaxa is
		port (
			autostart_external_connection_export                   : out   std_logic;                                        -- export
			clk_clk                                                : in    std_logic                     := 'X';             -- clk
			controlflagsin_external_connection_export              : out   std_logic_vector(1 downto 0);                     -- export
			controlflagsout_external_connection_export             : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			creditcount_external_connection_export                 : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			errorstatus_external_connection_export                 : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			linkdisable_external_connection_export                 : out   std_logic;                                        -- export
			linkstart_external_connection_export                   : out   std_logic;                                        -- export
			linkstatus_external_connection_export                  : in    std_logic_vector(15 downto 0) := (others => 'X'); -- export
			memory_mem_a                                           : out   std_logic_vector(12 downto 0);                    -- mem_a
			memory_mem_ba                                          : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                                          : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                                        : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                                         : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                                        : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                                       : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                                       : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                                        : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                                     : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                                          : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs                                         : inout std_logic                     := 'X';             -- mem_dqs
			memory_mem_dqs_n                                       : inout std_logic                     := 'X';             -- mem_dqs_n
			memory_mem_odt                                         : out   std_logic;                                        -- mem_odt
			memory_mem_dm                                          : out   std_logic;                                        -- mem_dm
			memory_oct_rzqin                                       : in    std_logic                     := 'X';             -- oct_rzqin
			outstandingcount_external_connection_export            : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			pll_0_outclk0_clk                                      : out   std_logic;                                        -- clk
			receiveactivity_external_connection_export             : in    std_logic                     := 'X';             -- export
			receiveclock_external_connection_export                : out   std_logic;                                        -- export
			receivefifodatacount_external_connection_export        : in    std_logic                     := 'X';             -- export
			receivefifodataout_external_connection_export          : in    std_logic_vector(8 downto 0)  := (others => 'X'); -- export
			receivefifoempty_external_connection_export            : in    std_logic                     := 'X';             -- export
			receivefifofull_external_connection_export             : in    std_logic                     := 'X';             -- export
			receivefiforeadenable_external_connection_export       : out   std_logic;                                        -- export
			spacewiredatain_external_connection_export             : out   std_logic;                                        -- export
			spacewiredataout_external_connection_export            : in    std_logic                     := 'X';             -- export
			spacewirestrobein_external_connection_export           : out   std_logic;                                        -- export
			spacewirestrobeout_external_connection_export          : in    std_logic                     := 'X';             -- export
			statisticalinformation_0_external_connection_export    : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			statisticalinformation_1_external_connection_export    : out   std_logic_vector(7 downto 0);                     -- export
			statisticalinformationclear_external_connection_export : out   std_logic;                                        -- export
			tickin_external_connection_export                      : out   std_logic;                                        -- export
			tickout_external_connection_export                     : in    std_logic                     := 'X';             -- export
			timein_external_connection_export                      : out   std_logic_vector(5 downto 0);                     -- export
			timeout_external_connection_export                     : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			transmitactivity_external_connection_export            : in    std_logic                     := 'X';             -- export
			transmitclock_external_connection_export               : out   std_logic;                                        -- export
			transmitclockdividevalue_external_connection_export    : out   std_logic_vector(5 downto 0);                     -- export
			transmitfifodatacount_external_connection_export       : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			transmitfifodatain_external_connection_export          : out   std_logic_vector(8 downto 0);                     -- export
			transmitfifofull_external_connection_export            : in    std_logic                     := 'X';             -- export
			transmitfifowriteenable_external_connection_export     : out   std_logic                                         -- export
		);
	end component jaxa;

	u0 : component jaxa
		port map (
			autostart_external_connection_export                   => CONNECTED_TO_autostart_external_connection_export,                   --                   autostart_external_connection.export
			clk_clk                                                => CONNECTED_TO_clk_clk,                                                --                                             clk.clk
			controlflagsin_external_connection_export              => CONNECTED_TO_controlflagsin_external_connection_export,              --              controlflagsin_external_connection.export
			controlflagsout_external_connection_export             => CONNECTED_TO_controlflagsout_external_connection_export,             --             controlflagsout_external_connection.export
			creditcount_external_connection_export                 => CONNECTED_TO_creditcount_external_connection_export,                 --                 creditcount_external_connection.export
			errorstatus_external_connection_export                 => CONNECTED_TO_errorstatus_external_connection_export,                 --                 errorstatus_external_connection.export
			linkdisable_external_connection_export                 => CONNECTED_TO_linkdisable_external_connection_export,                 --                 linkdisable_external_connection.export
			linkstart_external_connection_export                   => CONNECTED_TO_linkstart_external_connection_export,                   --                   linkstart_external_connection.export
			linkstatus_external_connection_export                  => CONNECTED_TO_linkstatus_external_connection_export,                  --                  linkstatus_external_connection.export
			memory_mem_a                                           => CONNECTED_TO_memory_mem_a,                                           --                                          memory.mem_a
			memory_mem_ba                                          => CONNECTED_TO_memory_mem_ba,                                          --                                                .mem_ba
			memory_mem_ck                                          => CONNECTED_TO_memory_mem_ck,                                          --                                                .mem_ck
			memory_mem_ck_n                                        => CONNECTED_TO_memory_mem_ck_n,                                        --                                                .mem_ck_n
			memory_mem_cke                                         => CONNECTED_TO_memory_mem_cke,                                         --                                                .mem_cke
			memory_mem_cs_n                                        => CONNECTED_TO_memory_mem_cs_n,                                        --                                                .mem_cs_n
			memory_mem_ras_n                                       => CONNECTED_TO_memory_mem_ras_n,                                       --                                                .mem_ras_n
			memory_mem_cas_n                                       => CONNECTED_TO_memory_mem_cas_n,                                       --                                                .mem_cas_n
			memory_mem_we_n                                        => CONNECTED_TO_memory_mem_we_n,                                        --                                                .mem_we_n
			memory_mem_reset_n                                     => CONNECTED_TO_memory_mem_reset_n,                                     --                                                .mem_reset_n
			memory_mem_dq                                          => CONNECTED_TO_memory_mem_dq,                                          --                                                .mem_dq
			memory_mem_dqs                                         => CONNECTED_TO_memory_mem_dqs,                                         --                                                .mem_dqs
			memory_mem_dqs_n                                       => CONNECTED_TO_memory_mem_dqs_n,                                       --                                                .mem_dqs_n
			memory_mem_odt                                         => CONNECTED_TO_memory_mem_odt,                                         --                                                .mem_odt
			memory_mem_dm                                          => CONNECTED_TO_memory_mem_dm,                                          --                                                .mem_dm
			memory_oct_rzqin                                       => CONNECTED_TO_memory_oct_rzqin,                                       --                                                .oct_rzqin
			outstandingcount_external_connection_export            => CONNECTED_TO_outstandingcount_external_connection_export,            --            outstandingcount_external_connection.export
			pll_0_outclk0_clk                                      => CONNECTED_TO_pll_0_outclk0_clk,                                      --                                   pll_0_outclk0.clk
			receiveactivity_external_connection_export             => CONNECTED_TO_receiveactivity_external_connection_export,             --             receiveactivity_external_connection.export
			receiveclock_external_connection_export                => CONNECTED_TO_receiveclock_external_connection_export,                --                receiveclock_external_connection.export
			receivefifodatacount_external_connection_export        => CONNECTED_TO_receivefifodatacount_external_connection_export,        --        receivefifodatacount_external_connection.export
			receivefifodataout_external_connection_export          => CONNECTED_TO_receivefifodataout_external_connection_export,          --          receivefifodataout_external_connection.export
			receivefifoempty_external_connection_export            => CONNECTED_TO_receivefifoempty_external_connection_export,            --            receivefifoempty_external_connection.export
			receivefifofull_external_connection_export             => CONNECTED_TO_receivefifofull_external_connection_export,             --             receivefifofull_external_connection.export
			receivefiforeadenable_external_connection_export       => CONNECTED_TO_receivefiforeadenable_external_connection_export,       --       receivefiforeadenable_external_connection.export
			spacewiredatain_external_connection_export             => CONNECTED_TO_spacewiredatain_external_connection_export,             --             spacewiredatain_external_connection.export
			spacewiredataout_external_connection_export            => CONNECTED_TO_spacewiredataout_external_connection_export,            --            spacewiredataout_external_connection.export
			spacewirestrobein_external_connection_export           => CONNECTED_TO_spacewirestrobein_external_connection_export,           --           spacewirestrobein_external_connection.export
			spacewirestrobeout_external_connection_export          => CONNECTED_TO_spacewirestrobeout_external_connection_export,          --          spacewirestrobeout_external_connection.export
			statisticalinformation_0_external_connection_export    => CONNECTED_TO_statisticalinformation_0_external_connection_export,    --    statisticalinformation_0_external_connection.export
			statisticalinformation_1_external_connection_export    => CONNECTED_TO_statisticalinformation_1_external_connection_export,    --    statisticalinformation_1_external_connection.export
			statisticalinformationclear_external_connection_export => CONNECTED_TO_statisticalinformationclear_external_connection_export, -- statisticalinformationclear_external_connection.export
			tickin_external_connection_export                      => CONNECTED_TO_tickin_external_connection_export,                      --                      tickin_external_connection.export
			tickout_external_connection_export                     => CONNECTED_TO_tickout_external_connection_export,                     --                     tickout_external_connection.export
			timein_external_connection_export                      => CONNECTED_TO_timein_external_connection_export,                      --                      timein_external_connection.export
			timeout_external_connection_export                     => CONNECTED_TO_timeout_external_connection_export,                     --                     timeout_external_connection.export
			transmitactivity_external_connection_export            => CONNECTED_TO_transmitactivity_external_connection_export,            --            transmitactivity_external_connection.export
			transmitclock_external_connection_export               => CONNECTED_TO_transmitclock_external_connection_export,               --               transmitclock_external_connection.export
			transmitclockdividevalue_external_connection_export    => CONNECTED_TO_transmitclockdividevalue_external_connection_export,    --    transmitclockdividevalue_external_connection.export
			transmitfifodatacount_external_connection_export       => CONNECTED_TO_transmitfifodatacount_external_connection_export,       --       transmitfifodatacount_external_connection.export
			transmitfifodatain_external_connection_export          => CONNECTED_TO_transmitfifodatain_external_connection_export,          --          transmitfifodatain_external_connection.export
			transmitfifofull_external_connection_export            => CONNECTED_TO_transmitfifofull_external_connection_export,            --            transmitfifofull_external_connection.export
			transmitfifowriteenable_external_connection_export     => CONNECTED_TO_transmitfifowriteenable_external_connection_export      --     transmitfifowriteenable_external_connection.export
		);

