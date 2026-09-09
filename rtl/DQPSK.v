module DQPSK (
    input               clk,
    input               rstn,
    input               en,
    input signed [1:0]  X_real,
    input signed [1:0]  X_imag,
    output signed [1:0] S_out_r,
    output signed [1:0] S_out_i
);
    // Internal wires (inputs and outputs of the shift register)
    wire signed [1:0] S_delayed_r, S_delayed_i;
    reg signed [1:0] S_next_r , S_next_i;


    // 4-stage delay line
    shift_reg #(.FF_num(4), .WIDTH(2)) delay_real_inst (.D(S_next_r), .clk(clk), .rstn(rstn), .en(en), .Q(S_delayed_r));

    shift_reg #(.FF_num(4), .WIDTH(2)) delay_imag_inst (.D(S_next_i), .clk(clk), .rstn(rstn), .en(en), .Q(S_delayed_i));

    // Complex multiplication
    always @(*) begin
        if (X_real == 2'b01 && X_imag == 2'b00) begin          // X_n = 1
            S_next_r = S_delayed_r;
            S_next_i = S_delayed_i;
        end else if (X_real == 2'b00 && X_imag == 2'b01) begin // X_n = j
            S_next_r = -S_delayed_i;                           // 2's complement negation
            S_next_i = S_delayed_r;
        end else if (X_real == 2'b11 && X_imag == 2'b00) begin // X_n = -1
            S_next_r = -S_delayed_r;
            S_next_i = -S_delayed_i;
        end else begin                                         // X_n = -j
            S_next_r = S_delayed_i;
            S_next_i = -S_delayed_r;
        end
    end


    // Final Output Assignment
    assign S_out_r = S_next_r;
    assign S_out_i = S_next_i;

endmodule
