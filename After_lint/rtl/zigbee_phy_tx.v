//////////////////////////////////////////////////////////////////////////////////
// Company: ITI
// Engineer: Mohab Elsayed
// 
// Create Date: 09/14/2026 10:10:57 AM
// Module Name: zigbee_phy_tx
// Project Name: Zigbee PHY TX

// Description: 
// The top module for the Zigbee PHY TX.
//////////////////////////////////////////////////////////////////////////////////

module zigbee_phy_tx (
    // System Clock and Reset
    input  wire         clk,
    input  wire         reset,            // Synchronous active-low system reset
    
    // MAC to PHY Interface
    input  wire         start_Tx,         // Pulse to initiate transmission
    input  wire [7:0]   payloadLength,    // Payload length in bytes (<= 127)
    input  wire [7:0]   payload_din,      // Payload data written to the payload RAM
    input  wire [7:0]   payload_addr,     // Write address for payload RAM
    input  wire         payload_wr_en,    //Write enable for payload RAM
    // Transmitter Outputs
    output wire         done_Tx,         	// Pulses high when the whole PPDU is transmitted
    output wire [7:0]   Tx_real,          	// Real part of the modulated CSS output sample
    output wire [7:0]   Tx_imag,           	// Imaginary part of the modulated CSS output sample
	output wire		    sample_valid		// Data on the Tx_real and Tx_imag are valid

);

    // ----------------------------------------------------------------- //
    //                  Internal Interconnect Signals
    // ----------------------------------------------------------------- //
    
    // Master Controller Signals
    wire        ready_for_IQ;
    wire        done_mod;
    wire        modulator_start;
    wire        IQ_valid;
    wire        last_group;
    wire        zp_en;
    wire [7:0]  sm_ram_rd_addr;
    wire [3:0]  rom_rd_addr;
    wire        ppdu_sel;
    wire        ppdu_out_en;
    wire        ppdu_load;
    wire        zp_mux_sel;

    // Zero Padder & Datapath MUX Signals
    wire [7:0]  payload_ram_dout;
    wire [6:0]  zp_ram_addr;
    wire [7:0]  zp_mux_out;
    wire        zp_serial_out;
    wire        zp_invalid_bit;
    wire        zp_recieved_start;
    // Demultiplexer Signals
    wire        demux_I;
    wire        demux_valid_I;
    wire        demux_Q;
    wire        demux_valid_Q;

    // Symbol Mapper RAM Signals
    wire [3:0]  sm_I_data;
    wire        sm_I_wr_en;
    wire [7:0]  sm_I_wr_addr;
    
    wire [3:0]  sm_Q_data;
    wire        sm_Q_wr_en;
    wire [7:0]  sm_Q_wr_addr;

    wire [3:0]  ram_I_out;
    wire [3:0]  ram_Q_out;

    // PPDU Former Signals
    wire        ppdu_I;
    wire        ppdu_Q;

    // ----------------------------------------------------------------- //
    //                   Modules Instantiations
    // ----------------------------------------------------------------- //

    // Master Control Finite State Machine
    master_ctrl_fsm u_ctrl_fsm (
        .clk                        (clk),
        .rst_n                      (reset),           
        .i_start_tx                 (start_Tx),
        .i_max_symbols              (sm_I_wr_addr),
        .i_ready_for_IQ             (ready_for_IQ),
        .i_done_mod                 (done_mod),
        .o_modulator_start          (modulator_start),
        .o_last_group               (last_group),
        .o_zp_en                    (zp_en),
        .o_sm_ram_rd_addr           (sm_ram_rd_addr),
        .o_preample_sfd_rom_rd_addr (rom_rd_addr),
        .o_ppdu_sel                 (ppdu_sel),
        .o_ppdu_out_en              (ppdu_out_en),
        .o_ppdu_load                (ppdu_load),
        .o_done_tx                  (done_Tx),
        .o_zp_mux_sel               (zp_mux_sel)
    );

    // Payload RAM (Simple Dual Port)
    payload_ram u_payload_ram (
        .clk                        (clk),
        .en_w                       (payload_wr_en),
        .wr_addr                    (payload_addr),
        .data_in                    (payload_din),
        .rd_addr                    ({1'b0, zp_ram_addr}), 
        .data_out                   (payload_ram_dout)
    ); 

    // Datapath Multiplexer (Routes Length or RAM Data to Zero Padder)
    mux2x1 #(
        .DATA_WIDTH                 (8)
    ) u_zp_mux (
        .in0                        (payloadLength),    // Selected when zp_mux_sel == 0
        .in1                        (payload_ram_dout), // Selected when zp_mux_sel == 1
        .sel                        (zp_mux_sel),
        .out                        (zp_mux_out)
    );

    // Zero Padder (Appends zeros to make payload divisible by 6)
    zero_padder u_zp (
        .i_payloadlength_data       (zp_mux_out),
        .i_start                    (zp_en),
        .i_clk                      (clk),
        .i_rstn                     (reset),            
        .o_serial                   (zp_serial_out),
        .o_invalid_bit              (zp_invalid_bit),
        .o_ram_address              (zp_ram_addr)
    );

    // Demultiplexer (Splits serial data into I and Q paths)
    demux u_demux (
        .i_serial                   (zp_serial_out),
        .i_invalid_bit              (zp_invalid_bit),
        .i_rstn                     (reset),            
        .i_clk                      (clk),
        .o_I                        (demux_I),
        .o_valid_I                  (demux_valid_I),
        .o_Q                        (demux_Q),
        .o_valid_Q                  (demux_valid_Q)
    );

    // Symbol Mapper - In-Phase (I) Path
    symbol_mapper u_sm_I (
        .clk                        (clk),
        .rstn                       (reset),
        .valid_in                   (demux_valid_I),
        .I                          (demux_I),
        .data_out                   (sm_I_data),
        .en_w                       (sm_I_wr_en),
        .wr_addr                    (sm_I_wr_addr)
    );

    // Symbol Mapper - Quadrature (Q) Path
    symbol_mapper u_sm_Q (
        .clk                        (clk),
        .rstn                       (reset),
        .valid_in                   (demux_valid_Q),
        .I                          (demux_Q),
        .data_out                   (sm_Q_data),
        .en_w                       (sm_Q_wr_en),
        .wr_addr                    (sm_Q_wr_addr)
    );

    // SM RAM - In-Phase (I) Path
    sm_ram u_sm_ram_I (
        .clk                        (clk),
        .en_w                       (sm_I_wr_en),
        .wr_addr                    (sm_I_wr_addr),
        .data_in                    (sm_I_data),
        .rd_addr                    (sm_ram_rd_addr),
        .data_out                   (ram_I_out)
    );

    // Elastic Buffer RAM - Quadrature (Q) Path
    sm_ram u_sm_ram_Q (
        .clk                        (clk),
        .en_w                       (sm_Q_wr_en),
        .wr_addr                    (sm_Q_wr_addr),
        .data_in                    (sm_Q_data),
        .rd_addr                    (sm_ram_rd_addr),
        .data_out                   (ram_Q_out)
    );

    // PPDU Former 
    form_ppdu #(
        .DATA_WIDTH                 (4),
        .ADDR_WIDTH                 (4)
    ) u_form_ppdu (
        .clk                        (clk),
        .out_en                     (ppdu_out_en),
        .load                       (ppdu_load),
        .sel                        (ppdu_sel),        //1 = preample_sfd , 0 = sm ram data
        .I_data                     (ram_I_out),
        .Q_data                     (ram_Q_out),
        .rom_addr                   (rom_rd_addr),
        .IQ_valid                   (IQ_valid),                   
        .I                          (ppdu_I),
        .Q                          (ppdu_Q)
    );

    //(QPSK Mapper -> DQPSK Encoder -> Chirp Modulator)
    qpsk_dqpsk_chirp_top u_mod_top (
        .clk                        (clk),
        .rst_n                      (reset),
        .start                      (modulator_start),
        .last_group                 (last_group),
        .I                          (ppdu_I),
        .Q                          (ppdu_Q),
        .IQ_valid                   (IQ_valid),
        .ready_for_IQ               (ready_for_IQ),
        .Tx_real                    (Tx_real),
        .Tx_imag                    (Tx_imag),
        .sample_valid               (sample_valid),
        .done_mod                   (done_mod)
    );

endmodule