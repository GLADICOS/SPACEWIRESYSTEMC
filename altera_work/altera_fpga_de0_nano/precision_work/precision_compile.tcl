new_project -name spw_ulight_con -folder {/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/precision_work}
new_impl -name spw_ulight_con_altera_impl
set_input_dir {/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/precision_work}
setup_design -design=spw_ulight_con
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_rsp_mux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_arbitrator.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_rsp_demux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_cmd_mux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_cmd_demux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_burst_adapter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_burst_adapter_uncmpr.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_burst_adapter_13_1.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_burst_adapter_new.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_incr_burst_converter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_wrap_burst_converter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_default_burst_converter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_address_alignment.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_avalon_st_pipeline_stage.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_avalon_st_pipeline_base.v}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_traffic_limiter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_reorder_memory.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_avalon_sc_fifo.v}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_router_002.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_router.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_slave_agent.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_burst_uncompressor.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_axi_master_ni.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_merlin_slave_translator.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_pll.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_phy_csr.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altdq_dqs2_acv_connect_to_hard_phy_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_mem_if_hard_memory_controller_top_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_mem_if_oct_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_mem_if_dll_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_hps_0_hps_io_border.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_hps_0_fpga_interfaces.sv}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/fsm_spw.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/rx_spw.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/tx_spw.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/spw_ulight_nofifo.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_reset_controller.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_reset_synchronizer.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_mm_interconnect_0_avalon_st_adapter.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_timec_tx_to_w.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_timec_rx_r.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_pll_tx.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_led_fpga.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_hps_0.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_hps_0_hps_io.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_clock_pair_generator.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_acv_hard_addr_cmd_pads.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_acv_hard_memphy.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_acv_ldc.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_acv_hard_io_pads.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_generic_ddio.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_reset.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_reset_sync.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_iss_probe.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/hps_sdram_p0_altdqdqs.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/altera_mem_if_hhp_qseq_synth_top.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_data_tx_to_w.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_data_rx_ready.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_data_rx_r.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_clock_sel.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_auto_start.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/spw_ulight_nofifo/synthesis/submodules/spw_ulight_nofifo_MONITOR_A.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/altera_fpga_de0_nano/rtl_top/spw_ulight_con.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/fpga_debug/detector_tokens.v}}
setup_design -manufacturer ALTERA -family {NO_FAMILY}  -part {} -speed {} 
setup_design -edif=TRUE
setup_design -addio=TRUE
setup_design -basename spw_ulight_con
setup_design -input_delay=0
if [catch {compile} err] {
	puts "Error: Errors found during compilation with Precision Synthesis tool"
	exit -force
} else {
	puts "report_status 20"
	puts "report_status 22"
	if [catch {synthesize} err] {
		puts "Error: Errors found during synthesis with Precision Synthesis tool"
		exit -force
	}
	puts "report_status 90"
	report_timing -all_clocks
	puts "report_status 92"
}
save_impl
puts "report_status 96"
close_project
