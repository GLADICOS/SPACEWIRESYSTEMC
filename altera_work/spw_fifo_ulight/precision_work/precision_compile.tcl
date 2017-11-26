new_project -name SPW_ULIGHT_FIFO -folder {/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/precision_work}
new_impl -name SPW_ULIGHT_FIFO_altera_impl
set_input_dir {/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/precision_work}
setup_design -design=SPW_ULIGHT_FIFO
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_rsp_mux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_arbitrator.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_rsp_demux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_cmd_mux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_cmd_demux.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_burst_adapter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_burst_adapter_uncmpr.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_burst_adapter_13_1.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_burst_adapter_new.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_incr_burst_converter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_wrap_burst_converter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_default_burst_converter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_address_alignment.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_avalon_st_pipeline_stage.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_avalon_st_pipeline_base.v}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_traffic_limiter.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_reorder_memory.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_avalon_sc_fifo.v}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_router_002.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_router.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_slave_agent.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_burst_uncompressor.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_axi_master_ni.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_merlin_slave_translator.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_pll.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_phy_csr.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altdq_dqs2_acv_connect_to_hard_phy_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_mem_if_hard_memory_controller_top_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_mem_if_oct_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_mem_if_dll_cyclonev.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_hps_0_hps_io_border.sv}}
add_input_file -format systemverilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_hps_0_fpga_interfaces.sv}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/fpga_debug/detector_tokens.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/fifo_rx.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/fifo_tx.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/fsm_spw.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/spw_ulight_con_top_x.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/rx_spw.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/top_spw_ultra_light.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/RTL_VB/tx_spw.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/fpga_debug/clock_reduce.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/rtl/fpga_debug/debounce.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/ulight_fifo.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_reset_controller.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_reset_synchronizer.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_mm_interconnect_0_avalon_st_adapter.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_write_data_fifo_tx.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_timecode_tx_data.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_timecode_rx.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_pll_0.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_led_pio_test.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_hps_0.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_hps_0_hps_io.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_clock_pair_generator.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_acv_hard_addr_cmd_pads.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_acv_hard_memphy.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_acv_ldc.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_acv_hard_io_pads.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_generic_ddio.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_reset.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_reset_sync.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_iss_probe.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/hps_sdram_p0_altdqdqs.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/altera_mem_if_hhp_qseq_synth_top.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_fifo_empty_rx_status.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_data_info.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_data_flag_rx.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_counter_rx_fifo.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_clock_sel.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/ulight_fifo/synthesis/submodules/ulight_fifo_auto_start.v}}
add_input_file -format verilog {{/home/felipe/Documentos/verilog_projects/SPW_SC/TESTSTRESS/spw_fifo_ulight/top_rtl/spw_fifo_ulight.v}}
setup_design -manufacturer ALTERA -family {NO_FAMILY}  -part {} -speed {} 
setup_design -edif=TRUE
setup_design -addio=TRUE
setup_design -basename SPW_ULIGHT_FIFO
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
