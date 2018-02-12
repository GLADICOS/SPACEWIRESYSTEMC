	component spw_babasu is
		port (
			autostart_external_connection_export    : out std_logic;                                        -- export
			clk_clk                                 : in  std_logic                     := 'X';             -- clk
			currentstate_external_connection_export : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- export
			data_i_external_connection_export       : out std_logic_vector(8 downto 0);                     -- export
			data_o_external_connection_export       : in  std_logic_vector(8 downto 0)  := (others => 'X'); -- export
			flags_external_connection_export        : in  std_logic_vector(10 downto 0) := (others => 'X'); -- export
			link_disable_external_connection_export : out std_logic;                                        -- export
			link_start_external_connection_export   : out std_logic;                                        -- export
			pll_0_locked_export                     : out std_logic;                                        -- export
			rd_data_external_connection_export      : out std_logic;                                        -- export
			reset_reset_n                           : in  std_logic                     := 'X';             -- reset_n
			rx_empty_external_connection_export     : in  std_logic                     := 'X';             -- export
			spill_enable_external_connection_export : out std_logic;                                        -- export
			tick_in_external_connection_export      : out std_logic;                                        -- export
			tick_out_external_connection_export     : in  std_logic                     := 'X';             -- export
			time_in_external_connection_export      : out std_logic_vector(7 downto 0);                     -- export
			time_out_external_connection_export     : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			tx_clk_div_external_connection_export   : out std_logic_vector(6 downto 0);                     -- export
			tx_full_external_connection_export      : in  std_logic                     := 'X';             -- export
			wr_data_external_connection_export      : out std_logic                                         -- export
		);
	end component spw_babasu;

	u0 : component spw_babasu
		port map (
			autostart_external_connection_export    => CONNECTED_TO_autostart_external_connection_export,    --    autostart_external_connection.export
			clk_clk                                 => CONNECTED_TO_clk_clk,                                 --                              clk.clk
			currentstate_external_connection_export => CONNECTED_TO_currentstate_external_connection_export, -- currentstate_external_connection.export
			data_i_external_connection_export       => CONNECTED_TO_data_i_external_connection_export,       --       data_i_external_connection.export
			data_o_external_connection_export       => CONNECTED_TO_data_o_external_connection_export,       --       data_o_external_connection.export
			flags_external_connection_export        => CONNECTED_TO_flags_external_connection_export,        --        flags_external_connection.export
			link_disable_external_connection_export => CONNECTED_TO_link_disable_external_connection_export, -- link_disable_external_connection.export
			link_start_external_connection_export   => CONNECTED_TO_link_start_external_connection_export,   --   link_start_external_connection.export
			pll_0_locked_export                     => CONNECTED_TO_pll_0_locked_export,                     --                     pll_0_locked.export
			rd_data_external_connection_export      => CONNECTED_TO_rd_data_external_connection_export,      --      rd_data_external_connection.export
			reset_reset_n                           => CONNECTED_TO_reset_reset_n,                           --                            reset.reset_n
			rx_empty_external_connection_export     => CONNECTED_TO_rx_empty_external_connection_export,     --     rx_empty_external_connection.export
			spill_enable_external_connection_export => CONNECTED_TO_spill_enable_external_connection_export, -- spill_enable_external_connection.export
			tick_in_external_connection_export      => CONNECTED_TO_tick_in_external_connection_export,      --      tick_in_external_connection.export
			tick_out_external_connection_export     => CONNECTED_TO_tick_out_external_connection_export,     --     tick_out_external_connection.export
			time_in_external_connection_export      => CONNECTED_TO_time_in_external_connection_export,      --      time_in_external_connection.export
			time_out_external_connection_export     => CONNECTED_TO_time_out_external_connection_export,     --     time_out_external_connection.export
			tx_clk_div_external_connection_export   => CONNECTED_TO_tx_clk_div_external_connection_export,   --   tx_clk_div_external_connection.export
			tx_full_external_connection_export      => CONNECTED_TO_tx_full_external_connection_export,      --      tx_full_external_connection.export
			wr_data_external_connection_export      => CONNECTED_TO_wr_data_external_connection_export       --      wr_data_external_connection.export
		);

