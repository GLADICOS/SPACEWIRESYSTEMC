	component spw_light is
		port (
			autostart_external_connection_export  : out   std_logic;                                        -- export
			clk_clk                               : in    std_logic                     := 'X';             -- clk
			connecting_external_connection_export : in    std_logic                     := 'X';             -- export
			ctrl_in_external_connection_export    : out   std_logic_vector(1 downto 0);                     -- export
			ctrl_out_external_connection_export   : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			errcred_external_connection_export    : in    std_logic                     := 'X';             -- export
			errdisc_external_connection_export    : in    std_logic                     := 'X';             -- export
			erresc_external_connection_export     : in    std_logic                     := 'X';             -- export
			errpar_external_connection_export     : in    std_logic                     := 'X';             -- export
			linkdis_external_connection_export    : out   std_logic;                                        -- export
			linkstart_external_connection_export  : out   std_logic;                                        -- export
			memory_mem_a                          : out   std_logic_vector(12 downto 0);                    -- mem_a
			memory_mem_ba                         : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                         : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                       : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                        : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                       : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                      : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                      : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                       : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                    : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                         : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs                        : inout std_logic                     := 'X';             -- mem_dqs
			memory_mem_dqs_n                      : inout std_logic                     := 'X';             -- mem_dqs_n
			memory_mem_odt                        : out   std_logic;                                        -- mem_odt
			memory_mem_dm                         : out   std_logic;                                        -- mem_dm
			memory_oct_rzqin                      : in    std_logic                     := 'X';             -- oct_rzqin
			pll_0_locked_export                   : out   std_logic;                                        -- export
			pll_0_outclk0_clk                     : out   std_logic;                                        -- clk
			reset_reset_n                         : in    std_logic                     := 'X';             -- reset_n
			running_external_connection_export    : in    std_logic                     := 'X';             -- export
			rxdata_external_connection_export     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			rxflag_external_connection_export     : in    std_logic                     := 'X';             -- export
			rxhalff_external_connection_export    : in    std_logic                     := 'X';             -- export
			rxread_external_connection_export     : out   std_logic;                                        -- export
			rxvalid_external_connection_export    : in    std_logic                     := 'X';             -- export
			started_external_connection_export    : in    std_logic                     := 'X';             -- export
			tick_in_external_connection_export    : out   std_logic;                                        -- export
			tick_out_external_connection_export   : in    std_logic                     := 'X';             -- export
			time_in_external_connection_export    : out   std_logic_vector(5 downto 0);                     -- export
			time_out_external_connection_export   : in    std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			txdata_external_connection_export     : out   std_logic_vector(7 downto 0);                     -- export
			txdivcnt_external_connection_export   : out   std_logic_vector(7 downto 0);                     -- export
			txflag_external_connection_export     : out   std_logic;                                        -- export
			txhalff_external_connection_export    : in    std_logic                     := 'X';             -- export
			txrdy_external_connection_export      : in    std_logic                     := 'X';             -- export
			txwrite_external_connection_export    : out   std_logic                                         -- export
		);
	end component spw_light;

	u0 : component spw_light
		port map (
			autostart_external_connection_export  => CONNECTED_TO_autostart_external_connection_export,  --  autostart_external_connection.export
			clk_clk                               => CONNECTED_TO_clk_clk,                               --                            clk.clk
			connecting_external_connection_export => CONNECTED_TO_connecting_external_connection_export, -- connecting_external_connection.export
			ctrl_in_external_connection_export    => CONNECTED_TO_ctrl_in_external_connection_export,    --    ctrl_in_external_connection.export
			ctrl_out_external_connection_export   => CONNECTED_TO_ctrl_out_external_connection_export,   --   ctrl_out_external_connection.export
			errcred_external_connection_export    => CONNECTED_TO_errcred_external_connection_export,    --    errcred_external_connection.export
			errdisc_external_connection_export    => CONNECTED_TO_errdisc_external_connection_export,    --    errdisc_external_connection.export
			erresc_external_connection_export     => CONNECTED_TO_erresc_external_connection_export,     --     erresc_external_connection.export
			errpar_external_connection_export     => CONNECTED_TO_errpar_external_connection_export,     --     errpar_external_connection.export
			linkdis_external_connection_export    => CONNECTED_TO_linkdis_external_connection_export,    --    linkdis_external_connection.export
			linkstart_external_connection_export  => CONNECTED_TO_linkstart_external_connection_export,  --  linkstart_external_connection.export
			memory_mem_a                          => CONNECTED_TO_memory_mem_a,                          --                         memory.mem_a
			memory_mem_ba                         => CONNECTED_TO_memory_mem_ba,                         --                               .mem_ba
			memory_mem_ck                         => CONNECTED_TO_memory_mem_ck,                         --                               .mem_ck
			memory_mem_ck_n                       => CONNECTED_TO_memory_mem_ck_n,                       --                               .mem_ck_n
			memory_mem_cke                        => CONNECTED_TO_memory_mem_cke,                        --                               .mem_cke
			memory_mem_cs_n                       => CONNECTED_TO_memory_mem_cs_n,                       --                               .mem_cs_n
			memory_mem_ras_n                      => CONNECTED_TO_memory_mem_ras_n,                      --                               .mem_ras_n
			memory_mem_cas_n                      => CONNECTED_TO_memory_mem_cas_n,                      --                               .mem_cas_n
			memory_mem_we_n                       => CONNECTED_TO_memory_mem_we_n,                       --                               .mem_we_n
			memory_mem_reset_n                    => CONNECTED_TO_memory_mem_reset_n,                    --                               .mem_reset_n
			memory_mem_dq                         => CONNECTED_TO_memory_mem_dq,                         --                               .mem_dq
			memory_mem_dqs                        => CONNECTED_TO_memory_mem_dqs,                        --                               .mem_dqs
			memory_mem_dqs_n                      => CONNECTED_TO_memory_mem_dqs_n,                      --                               .mem_dqs_n
			memory_mem_odt                        => CONNECTED_TO_memory_mem_odt,                        --                               .mem_odt
			memory_mem_dm                         => CONNECTED_TO_memory_mem_dm,                         --                               .mem_dm
			memory_oct_rzqin                      => CONNECTED_TO_memory_oct_rzqin,                      --                               .oct_rzqin
			pll_0_locked_export                   => CONNECTED_TO_pll_0_locked_export,                   --                   pll_0_locked.export
			pll_0_outclk0_clk                     => CONNECTED_TO_pll_0_outclk0_clk,                     --                  pll_0_outclk0.clk
			reset_reset_n                         => CONNECTED_TO_reset_reset_n,                         --                          reset.reset_n
			running_external_connection_export    => CONNECTED_TO_running_external_connection_export,    --    running_external_connection.export
			rxdata_external_connection_export     => CONNECTED_TO_rxdata_external_connection_export,     --     rxdata_external_connection.export
			rxflag_external_connection_export     => CONNECTED_TO_rxflag_external_connection_export,     --     rxflag_external_connection.export
			rxhalff_external_connection_export    => CONNECTED_TO_rxhalff_external_connection_export,    --    rxhalff_external_connection.export
			rxread_external_connection_export     => CONNECTED_TO_rxread_external_connection_export,     --     rxread_external_connection.export
			rxvalid_external_connection_export    => CONNECTED_TO_rxvalid_external_connection_export,    --    rxvalid_external_connection.export
			started_external_connection_export    => CONNECTED_TO_started_external_connection_export,    --    started_external_connection.export
			tick_in_external_connection_export    => CONNECTED_TO_tick_in_external_connection_export,    --    tick_in_external_connection.export
			tick_out_external_connection_export   => CONNECTED_TO_tick_out_external_connection_export,   --   tick_out_external_connection.export
			time_in_external_connection_export    => CONNECTED_TO_time_in_external_connection_export,    --    time_in_external_connection.export
			time_out_external_connection_export   => CONNECTED_TO_time_out_external_connection_export,   --   time_out_external_connection.export
			txdata_external_connection_export     => CONNECTED_TO_txdata_external_connection_export,     --     txdata_external_connection.export
			txdivcnt_external_connection_export   => CONNECTED_TO_txdivcnt_external_connection_export,   --   txdivcnt_external_connection.export
			txflag_external_connection_export     => CONNECTED_TO_txflag_external_connection_export,     --     txflag_external_connection.export
			txhalff_external_connection_export    => CONNECTED_TO_txhalff_external_connection_export,    --    txhalff_external_connection.export
			txrdy_external_connection_export      => CONNECTED_TO_txrdy_external_connection_export,      --      txrdy_external_connection.export
			txwrite_external_connection_export    => CONNECTED_TO_txwrite_external_connection_export     --    txwrite_external_connection.export
		);

