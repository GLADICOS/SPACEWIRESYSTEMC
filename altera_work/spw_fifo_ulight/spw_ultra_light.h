#ifndef _ALTERA_SPW_ULTRA_LIGHT_H_
#define _ALTERA_SPW_ULTRA_LIGHT_H_

/*
 * This file was automatically generated by the swinfo2header utility.
 * 
 * Created from SOPC Builder system 'ulight_fifo' in
 * file 'ulight_fifo.sopcinfo'.
 */

/*
 * This file contains macros for module 'hps_0' and devices
 * connected to the following master:
 *   h2f_axi_master
 * 
 * Do not include this header file and another header file created for a
 * different module or master group at the same time.
 * Doing so may result in duplicate macro names.
 * Instead, use the system header file which has macros with unique names.
 */

/*
 * Macros for device 'led_pio_test', class 'altera_avalon_pio'
 * The macros are prefixed with 'LED_PIO_TEST_'.
 * The prefix is the slave descriptor.
 */
#define LED_PIO_TEST_COMPONENT_TYPE altera_avalon_pio
#define LED_PIO_TEST_COMPONENT_NAME led_pio_test
#define LED_PIO_TEST_BASE 0x0
#define LED_PIO_TEST_SPAN 16
#define LED_PIO_TEST_END 0xf
#define LED_PIO_TEST_BIT_CLEARING_EDGE_REGISTER 0
#define LED_PIO_TEST_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_PIO_TEST_CAPTURE 0
#define LED_PIO_TEST_DATA_WIDTH 5
#define LED_PIO_TEST_DO_TEST_BENCH_WIRING 0
#define LED_PIO_TEST_DRIVEN_SIM_VALUE 0
#define LED_PIO_TEST_EDGE_TYPE NONE
#define LED_PIO_TEST_FREQ 50000000
#define LED_PIO_TEST_HAS_IN 0
#define LED_PIO_TEST_HAS_OUT 1
#define LED_PIO_TEST_HAS_TRI 0
#define LED_PIO_TEST_IRQ_TYPE NONE
#define LED_PIO_TEST_RESET_VALUE 0

/*
 * Macros for device 'timecode_rx', class 'altera_avalon_pio'
 * The macros are prefixed with 'TIMECODE_RX_'.
 * The prefix is the slave descriptor.
 */
#define TIMECODE_RX_COMPONENT_TYPE altera_avalon_pio
#define TIMECODE_RX_COMPONENT_NAME timecode_rx
#define TIMECODE_RX_BASE 0x10000
#define TIMECODE_RX_SPAN 16
#define TIMECODE_RX_END 0x1000f
#define TIMECODE_RX_BIT_CLEARING_EDGE_REGISTER 0
#define TIMECODE_RX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TIMECODE_RX_CAPTURE 0
#define TIMECODE_RX_DATA_WIDTH 8
#define TIMECODE_RX_DO_TEST_BENCH_WIRING 0
#define TIMECODE_RX_DRIVEN_SIM_VALUE 0
#define TIMECODE_RX_EDGE_TYPE NONE
#define TIMECODE_RX_FREQ 50000000
#define TIMECODE_RX_HAS_IN 1
#define TIMECODE_RX_HAS_OUT 0
#define TIMECODE_RX_HAS_TRI 0
#define TIMECODE_RX_IRQ_TYPE NONE
#define TIMECODE_RX_RESET_VALUE 0

/*
 * Macros for device 'timecode_tx_ready', class 'altera_avalon_pio'
 * The macros are prefixed with 'TIMECODE_TX_READY_'.
 * The prefix is the slave descriptor.
 */
#define TIMECODE_TX_READY_COMPONENT_TYPE altera_avalon_pio
#define TIMECODE_TX_READY_COMPONENT_NAME timecode_tx_ready
#define TIMECODE_TX_READY_BASE 0x1a000
#define TIMECODE_TX_READY_SPAN 16
#define TIMECODE_TX_READY_END 0x1a00f
#define TIMECODE_TX_READY_BIT_CLEARING_EDGE_REGISTER 0
#define TIMECODE_TX_READY_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TIMECODE_TX_READY_CAPTURE 0
#define TIMECODE_TX_READY_DATA_WIDTH 1
#define TIMECODE_TX_READY_DO_TEST_BENCH_WIRING 0
#define TIMECODE_TX_READY_DRIVEN_SIM_VALUE 0
#define TIMECODE_TX_READY_EDGE_TYPE NONE
#define TIMECODE_TX_READY_FREQ 50000000
#define TIMECODE_TX_READY_HAS_IN 1
#define TIMECODE_TX_READY_HAS_OUT 0
#define TIMECODE_TX_READY_HAS_TRI 0
#define TIMECODE_TX_READY_IRQ_TYPE NONE
#define TIMECODE_TX_READY_RESET_VALUE 0

/*
 * Macros for device 'timecode_ready_rx', class 'altera_avalon_pio'
 * The macros are prefixed with 'TIMECODE_READY_RX_'.
 * The prefix is the slave descriptor.
 */
#define TIMECODE_READY_RX_COMPONENT_TYPE altera_avalon_pio
#define TIMECODE_READY_RX_COMPONENT_NAME timecode_ready_rx
#define TIMECODE_READY_RX_BASE 0x20000
#define TIMECODE_READY_RX_SPAN 16
#define TIMECODE_READY_RX_END 0x2000f
#define TIMECODE_READY_RX_BIT_CLEARING_EDGE_REGISTER 0
#define TIMECODE_READY_RX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TIMECODE_READY_RX_CAPTURE 0
#define TIMECODE_READY_RX_DATA_WIDTH 1
#define TIMECODE_READY_RX_DO_TEST_BENCH_WIRING 0
#define TIMECODE_READY_RX_DRIVEN_SIM_VALUE 0
#define TIMECODE_READY_RX_EDGE_TYPE NONE
#define TIMECODE_READY_RX_FREQ 50000000
#define TIMECODE_READY_RX_HAS_IN 1
#define TIMECODE_READY_RX_HAS_OUT 0
#define TIMECODE_READY_RX_HAS_TRI 0
#define TIMECODE_READY_RX_IRQ_TYPE NONE
#define TIMECODE_READY_RX_RESET_VALUE 0

/*
 * Macros for device 'data_info', class 'altera_avalon_pio'
 * The macros are prefixed with 'DATA_INFO_'.
 * The prefix is the slave descriptor.
 */
#define DATA_INFO_COMPONENT_TYPE altera_avalon_pio
#define DATA_INFO_COMPONENT_NAME data_info
#define DATA_INFO_BASE 0x2a000
#define DATA_INFO_SPAN 16
#define DATA_INFO_END 0x2a00f
#define DATA_INFO_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_INFO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_INFO_CAPTURE 0
#define DATA_INFO_DATA_WIDTH 14
#define DATA_INFO_DO_TEST_BENCH_WIRING 0
#define DATA_INFO_DRIVEN_SIM_VALUE 0
#define DATA_INFO_EDGE_TYPE NONE
#define DATA_INFO_FREQ 50000000
#define DATA_INFO_HAS_IN 1
#define DATA_INFO_HAS_OUT 0
#define DATA_INFO_HAS_TRI 0
#define DATA_INFO_IRQ_TYPE NONE
#define DATA_INFO_RESET_VALUE 0

/*
 * Macros for device 'data_flag_rx', class 'altera_avalon_pio'
 * The macros are prefixed with 'DATA_FLAG_RX_'.
 * The prefix is the slave descriptor.
 */
#define DATA_FLAG_RX_COMPONENT_TYPE altera_avalon_pio
#define DATA_FLAG_RX_COMPONENT_NAME data_flag_rx
#define DATA_FLAG_RX_BASE 0x30000
#define DATA_FLAG_RX_SPAN 16
#define DATA_FLAG_RX_END 0x3000f
#define DATA_FLAG_RX_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_FLAG_RX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_FLAG_RX_CAPTURE 0
#define DATA_FLAG_RX_DATA_WIDTH 9
#define DATA_FLAG_RX_DO_TEST_BENCH_WIRING 0
#define DATA_FLAG_RX_DRIVEN_SIM_VALUE 0
#define DATA_FLAG_RX_EDGE_TYPE NONE
#define DATA_FLAG_RX_FREQ 50000000
#define DATA_FLAG_RX_HAS_IN 1
#define DATA_FLAG_RX_HAS_OUT 0
#define DATA_FLAG_RX_HAS_TRI 0
#define DATA_FLAG_RX_IRQ_TYPE NONE
#define DATA_FLAG_RX_RESET_VALUE 0

/*
 * Macros for device 'clock_sel', class 'altera_avalon_pio'
 * The macros are prefixed with 'CLOCK_SEL_'.
 * The prefix is the slave descriptor.
 */
#define CLOCK_SEL_COMPONENT_TYPE altera_avalon_pio
#define CLOCK_SEL_COMPONENT_NAME clock_sel
#define CLOCK_SEL_BASE 0x3a000
#define CLOCK_SEL_SPAN 16
#define CLOCK_SEL_END 0x3a00f
#define CLOCK_SEL_BIT_CLEARING_EDGE_REGISTER 0
#define CLOCK_SEL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CLOCK_SEL_CAPTURE 0
#define CLOCK_SEL_DATA_WIDTH 3
#define CLOCK_SEL_DO_TEST_BENCH_WIRING 0
#define CLOCK_SEL_DRIVEN_SIM_VALUE 0
#define CLOCK_SEL_EDGE_TYPE NONE
#define CLOCK_SEL_FREQ 50000000
#define CLOCK_SEL_HAS_IN 0
#define CLOCK_SEL_HAS_OUT 1
#define CLOCK_SEL_HAS_TRI 0
#define CLOCK_SEL_IRQ_TYPE NONE
#define CLOCK_SEL_RESET_VALUE 0

/*
 * Macros for device 'data_read_en_rx', class 'altera_avalon_pio'
 * The macros are prefixed with 'DATA_READ_EN_RX_'.
 * The prefix is the slave descriptor.
 */
#define DATA_READ_EN_RX_COMPONENT_TYPE altera_avalon_pio
#define DATA_READ_EN_RX_COMPONENT_NAME data_read_en_rx
#define DATA_READ_EN_RX_BASE 0x40000
#define DATA_READ_EN_RX_SPAN 16
#define DATA_READ_EN_RX_END 0x4000f
#define DATA_READ_EN_RX_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_READ_EN_RX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_READ_EN_RX_CAPTURE 0
#define DATA_READ_EN_RX_DATA_WIDTH 1
#define DATA_READ_EN_RX_DO_TEST_BENCH_WIRING 0
#define DATA_READ_EN_RX_DRIVEN_SIM_VALUE 0
#define DATA_READ_EN_RX_EDGE_TYPE NONE
#define DATA_READ_EN_RX_FREQ 50000000
#define DATA_READ_EN_RX_HAS_IN 0
#define DATA_READ_EN_RX_HAS_OUT 1
#define DATA_READ_EN_RX_HAS_TRI 0
#define DATA_READ_EN_RX_IRQ_TYPE NONE
#define DATA_READ_EN_RX_RESET_VALUE 0

/*
 * Macros for device 'fsm_info', class 'altera_avalon_pio'
 * The macros are prefixed with 'FSM_INFO_'.
 * The prefix is the slave descriptor.
 */
#define FSM_INFO_COMPONENT_TYPE altera_avalon_pio
#define FSM_INFO_COMPONENT_NAME fsm_info
#define FSM_INFO_BASE 0x4a000
#define FSM_INFO_SPAN 16
#define FSM_INFO_END 0x4a00f
#define FSM_INFO_BIT_CLEARING_EDGE_REGISTER 0
#define FSM_INFO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FSM_INFO_CAPTURE 0
#define FSM_INFO_DATA_WIDTH 6
#define FSM_INFO_DO_TEST_BENCH_WIRING 0
#define FSM_INFO_DRIVEN_SIM_VALUE 0
#define FSM_INFO_EDGE_TYPE NONE
#define FSM_INFO_FREQ 50000000
#define FSM_INFO_HAS_IN 1
#define FSM_INFO_HAS_OUT 0
#define FSM_INFO_HAS_TRI 0
#define FSM_INFO_IRQ_TYPE NONE
#define FSM_INFO_RESET_VALUE 0

/*
 * Macros for device 'fifo_full_rx_status', class 'altera_avalon_pio'
 * The macros are prefixed with 'FIFO_FULL_RX_STATUS_'.
 * The prefix is the slave descriptor.
 */
#define FIFO_FULL_RX_STATUS_COMPONENT_TYPE altera_avalon_pio
#define FIFO_FULL_RX_STATUS_COMPONENT_NAME fifo_full_rx_status
#define FIFO_FULL_RX_STATUS_BASE 0x50000
#define FIFO_FULL_RX_STATUS_SPAN 16
#define FIFO_FULL_RX_STATUS_END 0x5000f
#define FIFO_FULL_RX_STATUS_BIT_CLEARING_EDGE_REGISTER 0
#define FIFO_FULL_RX_STATUS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FIFO_FULL_RX_STATUS_CAPTURE 0
#define FIFO_FULL_RX_STATUS_DATA_WIDTH 1
#define FIFO_FULL_RX_STATUS_DO_TEST_BENCH_WIRING 0
#define FIFO_FULL_RX_STATUS_DRIVEN_SIM_VALUE 0
#define FIFO_FULL_RX_STATUS_EDGE_TYPE NONE
#define FIFO_FULL_RX_STATUS_FREQ 50000000
#define FIFO_FULL_RX_STATUS_HAS_IN 1
#define FIFO_FULL_RX_STATUS_HAS_OUT 0
#define FIFO_FULL_RX_STATUS_HAS_TRI 0
#define FIFO_FULL_RX_STATUS_IRQ_TYPE NONE
#define FIFO_FULL_RX_STATUS_RESET_VALUE 0

/*
 * Macros for device 'counter_tx_fifo', class 'altera_avalon_pio'
 * The macros are prefixed with 'COUNTER_TX_FIFO_'.
 * The prefix is the slave descriptor.
 */
#define COUNTER_TX_FIFO_COMPONENT_TYPE altera_avalon_pio
#define COUNTER_TX_FIFO_COMPONENT_NAME counter_tx_fifo
#define COUNTER_TX_FIFO_BASE 0x5a000
#define COUNTER_TX_FIFO_SPAN 16
#define COUNTER_TX_FIFO_END 0x5a00f
#define COUNTER_TX_FIFO_BIT_CLEARING_EDGE_REGISTER 0
#define COUNTER_TX_FIFO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define COUNTER_TX_FIFO_CAPTURE 0
#define COUNTER_TX_FIFO_DATA_WIDTH 6
#define COUNTER_TX_FIFO_DO_TEST_BENCH_WIRING 0
#define COUNTER_TX_FIFO_DRIVEN_SIM_VALUE 0
#define COUNTER_TX_FIFO_EDGE_TYPE NONE
#define COUNTER_TX_FIFO_FREQ 50000000
#define COUNTER_TX_FIFO_HAS_IN 1
#define COUNTER_TX_FIFO_HAS_OUT 0
#define COUNTER_TX_FIFO_HAS_TRI 0
#define COUNTER_TX_FIFO_IRQ_TYPE NONE
#define COUNTER_TX_FIFO_RESET_VALUE 0

/*
 * Macros for device 'fifo_empty_rx_status', class 'altera_avalon_pio'
 * The macros are prefixed with 'FIFO_EMPTY_RX_STATUS_'.
 * The prefix is the slave descriptor.
 */
#define FIFO_EMPTY_RX_STATUS_COMPONENT_TYPE altera_avalon_pio
#define FIFO_EMPTY_RX_STATUS_COMPONENT_NAME fifo_empty_rx_status
#define FIFO_EMPTY_RX_STATUS_BASE 0x60000
#define FIFO_EMPTY_RX_STATUS_SPAN 16
#define FIFO_EMPTY_RX_STATUS_END 0x6000f
#define FIFO_EMPTY_RX_STATUS_BIT_CLEARING_EDGE_REGISTER 0
#define FIFO_EMPTY_RX_STATUS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FIFO_EMPTY_RX_STATUS_CAPTURE 0
#define FIFO_EMPTY_RX_STATUS_DATA_WIDTH 1
#define FIFO_EMPTY_RX_STATUS_DO_TEST_BENCH_WIRING 0
#define FIFO_EMPTY_RX_STATUS_DRIVEN_SIM_VALUE 0
#define FIFO_EMPTY_RX_STATUS_EDGE_TYPE NONE
#define FIFO_EMPTY_RX_STATUS_FREQ 50000000
#define FIFO_EMPTY_RX_STATUS_HAS_IN 1
#define FIFO_EMPTY_RX_STATUS_HAS_OUT 0
#define FIFO_EMPTY_RX_STATUS_HAS_TRI 0
#define FIFO_EMPTY_RX_STATUS_IRQ_TYPE NONE
#define FIFO_EMPTY_RX_STATUS_RESET_VALUE 0

/*
 * Macros for device 'counter_rx_fifo', class 'altera_avalon_pio'
 * The macros are prefixed with 'COUNTER_RX_FIFO_'.
 * The prefix is the slave descriptor.
 */
#define COUNTER_RX_FIFO_COMPONENT_TYPE altera_avalon_pio
#define COUNTER_RX_FIFO_COMPONENT_NAME counter_rx_fifo
#define COUNTER_RX_FIFO_BASE 0x6a000
#define COUNTER_RX_FIFO_SPAN 16
#define COUNTER_RX_FIFO_END 0x6a00f
#define COUNTER_RX_FIFO_BIT_CLEARING_EDGE_REGISTER 0
#define COUNTER_RX_FIFO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define COUNTER_RX_FIFO_CAPTURE 0
#define COUNTER_RX_FIFO_DATA_WIDTH 6
#define COUNTER_RX_FIFO_DO_TEST_BENCH_WIRING 0
#define COUNTER_RX_FIFO_DRIVEN_SIM_VALUE 0
#define COUNTER_RX_FIFO_EDGE_TYPE NONE
#define COUNTER_RX_FIFO_FREQ 50000000
#define COUNTER_RX_FIFO_HAS_IN 1
#define COUNTER_RX_FIFO_HAS_OUT 0
#define COUNTER_RX_FIFO_HAS_TRI 0
#define COUNTER_RX_FIFO_IRQ_TYPE NONE
#define COUNTER_RX_FIFO_RESET_VALUE 0

/*
 * Macros for device 'link_start', class 'altera_avalon_pio'
 * The macros are prefixed with 'LINK_START_'.
 * The prefix is the slave descriptor.
 */
#define LINK_START_COMPONENT_TYPE altera_avalon_pio
#define LINK_START_COMPONENT_NAME link_start
#define LINK_START_BASE 0x70000
#define LINK_START_SPAN 16
#define LINK_START_END 0x7000f
#define LINK_START_BIT_CLEARING_EDGE_REGISTER 0
#define LINK_START_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LINK_START_CAPTURE 0
#define LINK_START_DATA_WIDTH 1
#define LINK_START_DO_TEST_BENCH_WIRING 0
#define LINK_START_DRIVEN_SIM_VALUE 0
#define LINK_START_EDGE_TYPE NONE
#define LINK_START_FREQ 50000000
#define LINK_START_HAS_IN 0
#define LINK_START_HAS_OUT 1
#define LINK_START_HAS_TRI 0
#define LINK_START_IRQ_TYPE NONE
#define LINK_START_RESET_VALUE 0

/*
 * Macros for device 'auto_start', class 'altera_avalon_pio'
 * The macros are prefixed with 'AUTO_START_'.
 * The prefix is the slave descriptor.
 */
#define AUTO_START_COMPONENT_TYPE altera_avalon_pio
#define AUTO_START_COMPONENT_NAME auto_start
#define AUTO_START_BASE 0x80000
#define AUTO_START_SPAN 16
#define AUTO_START_END 0x8000f
#define AUTO_START_BIT_CLEARING_EDGE_REGISTER 0
#define AUTO_START_BIT_MODIFYING_OUTPUT_REGISTER 0
#define AUTO_START_CAPTURE 0
#define AUTO_START_DATA_WIDTH 1
#define AUTO_START_DO_TEST_BENCH_WIRING 0
#define AUTO_START_DRIVEN_SIM_VALUE 0
#define AUTO_START_EDGE_TYPE NONE
#define AUTO_START_FREQ 50000000
#define AUTO_START_HAS_IN 0
#define AUTO_START_HAS_OUT 1
#define AUTO_START_HAS_TRI 0
#define AUTO_START_IRQ_TYPE NONE
#define AUTO_START_RESET_VALUE 0

/*
 * Macros for device 'link_disable', class 'altera_avalon_pio'
 * The macros are prefixed with 'LINK_DISABLE_'.
 * The prefix is the slave descriptor.
 */
#define LINK_DISABLE_COMPONENT_TYPE altera_avalon_pio
#define LINK_DISABLE_COMPONENT_NAME link_disable
#define LINK_DISABLE_BASE 0x90000
#define LINK_DISABLE_SPAN 16
#define LINK_DISABLE_END 0x9000f
#define LINK_DISABLE_BIT_CLEARING_EDGE_REGISTER 0
#define LINK_DISABLE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LINK_DISABLE_CAPTURE 0
#define LINK_DISABLE_DATA_WIDTH 1
#define LINK_DISABLE_DO_TEST_BENCH_WIRING 0
#define LINK_DISABLE_DRIVEN_SIM_VALUE 0
#define LINK_DISABLE_EDGE_TYPE NONE
#define LINK_DISABLE_FREQ 50000000
#define LINK_DISABLE_HAS_IN 0
#define LINK_DISABLE_HAS_OUT 1
#define LINK_DISABLE_HAS_TRI 0
#define LINK_DISABLE_IRQ_TYPE NONE
#define LINK_DISABLE_RESET_VALUE 0

/*
 * Macros for device 'write_data_fifo_tx', class 'altera_avalon_pio'
 * The macros are prefixed with 'WRITE_DATA_FIFO_TX_'.
 * The prefix is the slave descriptor.
 */
#define WRITE_DATA_FIFO_TX_COMPONENT_TYPE altera_avalon_pio
#define WRITE_DATA_FIFO_TX_COMPONENT_NAME write_data_fifo_tx
#define WRITE_DATA_FIFO_TX_BASE 0xa0000
#define WRITE_DATA_FIFO_TX_SPAN 16
#define WRITE_DATA_FIFO_TX_END 0xa000f
#define WRITE_DATA_FIFO_TX_BIT_CLEARING_EDGE_REGISTER 0
#define WRITE_DATA_FIFO_TX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WRITE_DATA_FIFO_TX_CAPTURE 0
#define WRITE_DATA_FIFO_TX_DATA_WIDTH 9
#define WRITE_DATA_FIFO_TX_DO_TEST_BENCH_WIRING 0
#define WRITE_DATA_FIFO_TX_DRIVEN_SIM_VALUE 0
#define WRITE_DATA_FIFO_TX_EDGE_TYPE NONE
#define WRITE_DATA_FIFO_TX_FREQ 50000000
#define WRITE_DATA_FIFO_TX_HAS_IN 0
#define WRITE_DATA_FIFO_TX_HAS_OUT 1
#define WRITE_DATA_FIFO_TX_HAS_TRI 0
#define WRITE_DATA_FIFO_TX_IRQ_TYPE NONE
#define WRITE_DATA_FIFO_TX_RESET_VALUE 0

/*
 * Macros for device 'write_en_tx', class 'altera_avalon_pio'
 * The macros are prefixed with 'WRITE_EN_TX_'.
 * The prefix is the slave descriptor.
 */
#define WRITE_EN_TX_COMPONENT_TYPE altera_avalon_pio
#define WRITE_EN_TX_COMPONENT_NAME write_en_tx
#define WRITE_EN_TX_BASE 0xb0000
#define WRITE_EN_TX_SPAN 16
#define WRITE_EN_TX_END 0xb000f
#define WRITE_EN_TX_BIT_CLEARING_EDGE_REGISTER 0
#define WRITE_EN_TX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define WRITE_EN_TX_CAPTURE 0
#define WRITE_EN_TX_DATA_WIDTH 1
#define WRITE_EN_TX_DO_TEST_BENCH_WIRING 0
#define WRITE_EN_TX_DRIVEN_SIM_VALUE 0
#define WRITE_EN_TX_EDGE_TYPE NONE
#define WRITE_EN_TX_FREQ 50000000
#define WRITE_EN_TX_HAS_IN 0
#define WRITE_EN_TX_HAS_OUT 1
#define WRITE_EN_TX_HAS_TRI 0
#define WRITE_EN_TX_IRQ_TYPE NONE
#define WRITE_EN_TX_RESET_VALUE 0

/*
 * Macros for device 'fifo_full_tx_status', class 'altera_avalon_pio'
 * The macros are prefixed with 'FIFO_FULL_TX_STATUS_'.
 * The prefix is the slave descriptor.
 */
#define FIFO_FULL_TX_STATUS_COMPONENT_TYPE altera_avalon_pio
#define FIFO_FULL_TX_STATUS_COMPONENT_NAME fifo_full_tx_status
#define FIFO_FULL_TX_STATUS_BASE 0xc0000
#define FIFO_FULL_TX_STATUS_SPAN 16
#define FIFO_FULL_TX_STATUS_END 0xc000f
#define FIFO_FULL_TX_STATUS_BIT_CLEARING_EDGE_REGISTER 0
#define FIFO_FULL_TX_STATUS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FIFO_FULL_TX_STATUS_CAPTURE 0
#define FIFO_FULL_TX_STATUS_DATA_WIDTH 1
#define FIFO_FULL_TX_STATUS_DO_TEST_BENCH_WIRING 0
#define FIFO_FULL_TX_STATUS_DRIVEN_SIM_VALUE 0
#define FIFO_FULL_TX_STATUS_EDGE_TYPE NONE
#define FIFO_FULL_TX_STATUS_FREQ 50000000
#define FIFO_FULL_TX_STATUS_HAS_IN 1
#define FIFO_FULL_TX_STATUS_HAS_OUT 0
#define FIFO_FULL_TX_STATUS_HAS_TRI 0
#define FIFO_FULL_TX_STATUS_IRQ_TYPE NONE
#define FIFO_FULL_TX_STATUS_RESET_VALUE 0

/*
 * Macros for device 'fifo_empty_tx_status', class 'altera_avalon_pio'
 * The macros are prefixed with 'FIFO_EMPTY_TX_STATUS_'.
 * The prefix is the slave descriptor.
 */
#define FIFO_EMPTY_TX_STATUS_COMPONENT_TYPE altera_avalon_pio
#define FIFO_EMPTY_TX_STATUS_COMPONENT_NAME fifo_empty_tx_status
#define FIFO_EMPTY_TX_STATUS_BASE 0xd0000
#define FIFO_EMPTY_TX_STATUS_SPAN 16
#define FIFO_EMPTY_TX_STATUS_END 0xd000f
#define FIFO_EMPTY_TX_STATUS_BIT_CLEARING_EDGE_REGISTER 0
#define FIFO_EMPTY_TX_STATUS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define FIFO_EMPTY_TX_STATUS_CAPTURE 0
#define FIFO_EMPTY_TX_STATUS_DATA_WIDTH 1
#define FIFO_EMPTY_TX_STATUS_DO_TEST_BENCH_WIRING 0
#define FIFO_EMPTY_TX_STATUS_DRIVEN_SIM_VALUE 0
#define FIFO_EMPTY_TX_STATUS_EDGE_TYPE NONE
#define FIFO_EMPTY_TX_STATUS_FREQ 50000000
#define FIFO_EMPTY_TX_STATUS_HAS_IN 1
#define FIFO_EMPTY_TX_STATUS_HAS_OUT 0
#define FIFO_EMPTY_TX_STATUS_HAS_TRI 0
#define FIFO_EMPTY_TX_STATUS_IRQ_TYPE NONE
#define FIFO_EMPTY_TX_STATUS_RESET_VALUE 0

/*
 * Macros for device 'timecode_tx_data', class 'altera_avalon_pio'
 * The macros are prefixed with 'TIMECODE_TX_DATA_'.
 * The prefix is the slave descriptor.
 */
#define TIMECODE_TX_DATA_COMPONENT_TYPE altera_avalon_pio
#define TIMECODE_TX_DATA_COMPONENT_NAME timecode_tx_data
#define TIMECODE_TX_DATA_BASE 0xe0000
#define TIMECODE_TX_DATA_SPAN 16
#define TIMECODE_TX_DATA_END 0xe000f
#define TIMECODE_TX_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define TIMECODE_TX_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TIMECODE_TX_DATA_CAPTURE 0
#define TIMECODE_TX_DATA_DATA_WIDTH 8
#define TIMECODE_TX_DATA_DO_TEST_BENCH_WIRING 0
#define TIMECODE_TX_DATA_DRIVEN_SIM_VALUE 0
#define TIMECODE_TX_DATA_EDGE_TYPE NONE
#define TIMECODE_TX_DATA_FREQ 50000000
#define TIMECODE_TX_DATA_HAS_IN 0
#define TIMECODE_TX_DATA_HAS_OUT 1
#define TIMECODE_TX_DATA_HAS_TRI 0
#define TIMECODE_TX_DATA_IRQ_TYPE NONE
#define TIMECODE_TX_DATA_RESET_VALUE 0

/*
 * Macros for device 'timecode_tx_enable', class 'altera_avalon_pio'
 * The macros are prefixed with 'TIMECODE_TX_ENABLE_'.
 * The prefix is the slave descriptor.
 */
#define TIMECODE_TX_ENABLE_COMPONENT_TYPE altera_avalon_pio
#define TIMECODE_TX_ENABLE_COMPONENT_NAME timecode_tx_enable
#define TIMECODE_TX_ENABLE_BASE 0xf0000
#define TIMECODE_TX_ENABLE_SPAN 16
#define TIMECODE_TX_ENABLE_END 0xf000f
#define TIMECODE_TX_ENABLE_BIT_CLEARING_EDGE_REGISTER 0
#define TIMECODE_TX_ENABLE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TIMECODE_TX_ENABLE_CAPTURE 0
#define TIMECODE_TX_ENABLE_DATA_WIDTH 1
#define TIMECODE_TX_ENABLE_DO_TEST_BENCH_WIRING 0
#define TIMECODE_TX_ENABLE_DRIVEN_SIM_VALUE 0
#define TIMECODE_TX_ENABLE_EDGE_TYPE NONE
#define TIMECODE_TX_ENABLE_FREQ 50000000
#define TIMECODE_TX_ENABLE_HAS_IN 0
#define TIMECODE_TX_ENABLE_HAS_OUT 1
#define TIMECODE_TX_ENABLE_HAS_TRI 0
#define TIMECODE_TX_ENABLE_IRQ_TYPE NONE
#define TIMECODE_TX_ENABLE_RESET_VALUE 0


#endif /* _ALTERA_SPW_ULTRA_LIGHT_H_ */
