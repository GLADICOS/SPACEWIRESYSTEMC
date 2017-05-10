	component spw_ulight_nofifo is
		port (
			auto_start_0_external_connection_export      : out std_logic;                                        -- export
			auto_start_external_connection_export        : out std_logic;                                        -- export
			clk_clk                                      : in  std_logic                     := 'X';             -- clk
			clock_sel_external_connection_export         : out std_logic_vector(2 downto 0);                     -- export
			credit_error_rx_0_external_connection_export : out std_logic;                                        -- export
			credit_error_rx_external_connection_export   : out std_logic;                                        -- export
			data_en_to_w_0_external_connection_export    : out std_logic;                                        -- export
			data_en_to_w_external_connection_export      : out std_logic;                                        -- export
			data_rx_r_0_external_connection_export       : in  std_logic_vector(8 downto 0)  := (others => 'X'); -- export
			data_rx_r_external_connection_export         : in  std_logic_vector(8 downto 0)  := (others => 'X'); -- export
			data_rx_ready_0_external_connection_export   : in  std_logic                     := 'X';             -- export
			data_rx_ready_external_connection_export     : out std_logic;                                        -- export
			data_tx_ready_0_external_connection_export   : in  std_logic                     := 'X';             -- export
			data_tx_ready_external_connection_export     : in  std_logic                     := 'X';             -- export
			data_tx_to_w_0_external_connection_export    : out std_logic_vector(8 downto 0);                     -- export
			data_tx_to_w_external_connection_export      : out std_logic_vector(8 downto 0);                     -- export
			fsm_info_0_external_connection_export        : in  std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			fsm_info_external_connection_export          : in  std_logic_vector(5 downto 0)  := (others => 'X'); -- export
			led_fpga_external_connection_export          : out std_logic_vector(5 downto 0);                     -- export
			link_disable_0_external_connection_export    : out std_logic;                                        -- export
			link_disable_external_connection_export      : out std_logic;                                        -- export
			link_start_0_external_connection_export      : out std_logic;                                        -- export
			link_start_external_connection_export        : out std_logic;                                        -- export
			monitor_a_external_connection_export         : in  std_logic_vector(13 downto 0) := (others => 'X'); -- export
			monitor_b_external_connection_export         : in  std_logic_vector(13 downto 0) := (others => 'X'); -- export
			pll_tx_locked_export                         : out std_logic;                                        -- export
			pll_tx_outclk0_clk                           : out std_logic;                                        -- clk
			pll_tx_outclk1_clk                           : out std_logic;                                        -- clk
			pll_tx_outclk2_clk                           : out std_logic;                                        -- clk
			pll_tx_outclk3_clk                           : out std_logic;                                        -- clk
			pll_tx_outclk4_clk                           : out std_logic;                                        -- clk
			reset_reset_n                                : in  std_logic                     := 'X';             -- reset_n
			send_fct_now_0_external_connection_export    : out std_logic;                                        -- export
			send_fct_now_external_connection_export      : out std_logic;                                        -- export
			timec_en_to_tx_0_external_connection_export  : out std_logic;                                        -- export
			timec_en_to_tx_external_connection_export    : out std_logic;                                        -- export
			timec_rx_r_0_external_connection_export      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			timec_rx_r_external_connection_export        : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			timec_rx_ready_0_external_connection_export  : in  std_logic                     := 'X';             -- export
			timec_rx_ready_external_connection_export    : in  std_logic                     := 'X';             -- export
			timec_tx_ready_0_external_connection_export  : in  std_logic                     := 'X';             -- export
			timec_tx_ready_external_connection_export    : in  std_logic                     := 'X';             -- export
			timec_tx_to_w_0_external_connection_export   : out std_logic_vector(7 downto 0);                     -- export
			timec_tx_to_w_external_connection_export     : out std_logic_vector(7 downto 0)                      -- export
		);
	end component spw_ulight_nofifo;

	u0 : component spw_ulight_nofifo
		port map (
			auto_start_0_external_connection_export      => CONNECTED_TO_auto_start_0_external_connection_export,      --      auto_start_0_external_connection.export
			auto_start_external_connection_export        => CONNECTED_TO_auto_start_external_connection_export,        --        auto_start_external_connection.export
			clk_clk                                      => CONNECTED_TO_clk_clk,                                      --                                   clk.clk
			clock_sel_external_connection_export         => CONNECTED_TO_clock_sel_external_connection_export,         --         clock_sel_external_connection.export
			credit_error_rx_0_external_connection_export => CONNECTED_TO_credit_error_rx_0_external_connection_export, -- credit_error_rx_0_external_connection.export
			credit_error_rx_external_connection_export   => CONNECTED_TO_credit_error_rx_external_connection_export,   --   credit_error_rx_external_connection.export
			data_en_to_w_0_external_connection_export    => CONNECTED_TO_data_en_to_w_0_external_connection_export,    --    data_en_to_w_0_external_connection.export
			data_en_to_w_external_connection_export      => CONNECTED_TO_data_en_to_w_external_connection_export,      --      data_en_to_w_external_connection.export
			data_rx_r_0_external_connection_export       => CONNECTED_TO_data_rx_r_0_external_connection_export,       --       data_rx_r_0_external_connection.export
			data_rx_r_external_connection_export         => CONNECTED_TO_data_rx_r_external_connection_export,         --         data_rx_r_external_connection.export
			data_rx_ready_0_external_connection_export   => CONNECTED_TO_data_rx_ready_0_external_connection_export,   --   data_rx_ready_0_external_connection.export
			data_rx_ready_external_connection_export     => CONNECTED_TO_data_rx_ready_external_connection_export,     --     data_rx_ready_external_connection.export
			data_tx_ready_0_external_connection_export   => CONNECTED_TO_data_tx_ready_0_external_connection_export,   --   data_tx_ready_0_external_connection.export
			data_tx_ready_external_connection_export     => CONNECTED_TO_data_tx_ready_external_connection_export,     --     data_tx_ready_external_connection.export
			data_tx_to_w_0_external_connection_export    => CONNECTED_TO_data_tx_to_w_0_external_connection_export,    --    data_tx_to_w_0_external_connection.export
			data_tx_to_w_external_connection_export      => CONNECTED_TO_data_tx_to_w_external_connection_export,      --      data_tx_to_w_external_connection.export
			fsm_info_0_external_connection_export        => CONNECTED_TO_fsm_info_0_external_connection_export,        --        fsm_info_0_external_connection.export
			fsm_info_external_connection_export          => CONNECTED_TO_fsm_info_external_connection_export,          --          fsm_info_external_connection.export
			led_fpga_external_connection_export          => CONNECTED_TO_led_fpga_external_connection_export,          --          led_fpga_external_connection.export
			link_disable_0_external_connection_export    => CONNECTED_TO_link_disable_0_external_connection_export,    --    link_disable_0_external_connection.export
			link_disable_external_connection_export      => CONNECTED_TO_link_disable_external_connection_export,      --      link_disable_external_connection.export
			link_start_0_external_connection_export      => CONNECTED_TO_link_start_0_external_connection_export,      --      link_start_0_external_connection.export
			link_start_external_connection_export        => CONNECTED_TO_link_start_external_connection_export,        --        link_start_external_connection.export
			monitor_a_external_connection_export         => CONNECTED_TO_monitor_a_external_connection_export,         --         monitor_a_external_connection.export
			monitor_b_external_connection_export         => CONNECTED_TO_monitor_b_external_connection_export,         --         monitor_b_external_connection.export
			pll_tx_locked_export                         => CONNECTED_TO_pll_tx_locked_export,                         --                         pll_tx_locked.export
			pll_tx_outclk0_clk                           => CONNECTED_TO_pll_tx_outclk0_clk,                           --                        pll_tx_outclk0.clk
			pll_tx_outclk1_clk                           => CONNECTED_TO_pll_tx_outclk1_clk,                           --                        pll_tx_outclk1.clk
			pll_tx_outclk2_clk                           => CONNECTED_TO_pll_tx_outclk2_clk,                           --                        pll_tx_outclk2.clk
			pll_tx_outclk3_clk                           => CONNECTED_TO_pll_tx_outclk3_clk,                           --                        pll_tx_outclk3.clk
			pll_tx_outclk4_clk                           => CONNECTED_TO_pll_tx_outclk4_clk,                           --                        pll_tx_outclk4.clk
			reset_reset_n                                => CONNECTED_TO_reset_reset_n,                                --                                 reset.reset_n
			send_fct_now_0_external_connection_export    => CONNECTED_TO_send_fct_now_0_external_connection_export,    --    send_fct_now_0_external_connection.export
			send_fct_now_external_connection_export      => CONNECTED_TO_send_fct_now_external_connection_export,      --      send_fct_now_external_connection.export
			timec_en_to_tx_0_external_connection_export  => CONNECTED_TO_timec_en_to_tx_0_external_connection_export,  --  timec_en_to_tx_0_external_connection.export
			timec_en_to_tx_external_connection_export    => CONNECTED_TO_timec_en_to_tx_external_connection_export,    --    timec_en_to_tx_external_connection.export
			timec_rx_r_0_external_connection_export      => CONNECTED_TO_timec_rx_r_0_external_connection_export,      --      timec_rx_r_0_external_connection.export
			timec_rx_r_external_connection_export        => CONNECTED_TO_timec_rx_r_external_connection_export,        --        timec_rx_r_external_connection.export
			timec_rx_ready_0_external_connection_export  => CONNECTED_TO_timec_rx_ready_0_external_connection_export,  --  timec_rx_ready_0_external_connection.export
			timec_rx_ready_external_connection_export    => CONNECTED_TO_timec_rx_ready_external_connection_export,    --    timec_rx_ready_external_connection.export
			timec_tx_ready_0_external_connection_export  => CONNECTED_TO_timec_tx_ready_0_external_connection_export,  --  timec_tx_ready_0_external_connection.export
			timec_tx_ready_external_connection_export    => CONNECTED_TO_timec_tx_ready_external_connection_export,    --    timec_tx_ready_external_connection.export
			timec_tx_to_w_0_external_connection_export   => CONNECTED_TO_timec_tx_to_w_0_external_connection_export,   --   timec_tx_to_w_0_external_connection.export
			timec_tx_to_w_external_connection_export     => CONNECTED_TO_timec_tx_to_w_external_connection_export      --     timec_tx_to_w_external_connection.export
		);

