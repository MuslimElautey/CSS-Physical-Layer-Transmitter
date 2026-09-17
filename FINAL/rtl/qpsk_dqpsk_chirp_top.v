// ===================================================================
// Module: qpsk_dqpsk_chirp_top
// Connects: qpsk_mapper -> dqpsk_encoder -> chirp_modulation
// Testbench feeds I,Q whenever ready_for_IQ (=chirp's sn_req) is high.
// ===================================================================
module qpsk_dqpsk_chirp_top (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire last_group,

    // Testbench-driven inputs
    input  wire I,
    input  wire Q,
    input  wire IQ_valid,      // pulse: I,Q are valid this cycle

    // Handshake output to testbench
    output wire ready_for_IQ,  // = 1 : module wants the next I,Q pair now

    // Final chirp output
    output wire signed [7:0] Tx_real,
    output wire signed [7:0] Tx_imag,
    output wire              sample_valid,
    output wire              done_mod
);

    // --- QPSK mapper (combinational) ---
    wire signed [1:0] x_real, x_imag;
    qpsk_mapper u_qpsk (
        .I(I), .Q(Q),
        .real_out(x_real), .imag_out(x_imag)
    );

    // --- DQPSK encoder (1-cycle registered) ---
    wire signed [1:0] s_real, s_imag;
    dqpsk_encoder u_dqpsk (
        .clk(clk), .rst_n(rst_n), .en(IQ_valid),
        .real_in(x_real), .imag_in(x_imag),
        .real_out(s_real), .imag_out(s_imag)
    );

    // Delay sn_valid by 1 cycle to match dqpsk_encoder's output latency
    reg sn_valid_d;
    always @(posedge clk) begin
        if (!rst_n) sn_valid_d <= 1'b0;
        else        sn_valid_d <= IQ_valid;
    end

    // --- Chirp modulation ---
    chirp_modulation u_chirp (
        .clk(clk), .rst_n(rst_n), .start(start), .last_group(last_group),
        .sn_real(s_real), .sn_imag(s_imag), .sn_valid(sn_valid_d),
        .sn_req(ready_for_IQ),
        .Tx_real(Tx_real), .Tx_imag(Tx_imag),
        .sample_valid(sample_valid), .done_mod(done_mod)
    );

endmodule