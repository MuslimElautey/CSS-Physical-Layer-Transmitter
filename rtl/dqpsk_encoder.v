module dqpsk_encoder (
    input  wire              clk,
    input  wire              rst_n,   // active-low reset
    input  wire              en,      // 1 = new QPSK symbol this cycle
    input  wire signed [1:0] real_in, // X_real  (from qpsk_mapper)
    input  wire signed [1:0] imag_in, // X_imag
    output reg  signed [1:0] real_out,// S_n real
    output reg  signed [1:0] imag_out // S_n imag
);

    // -------------------------------------------------------------- //
    // Circular buffer of length 4: stores the last 4 S values
    // (feedback memory), used to implement Sn = Xn * S(n-4)
    // -------------------------------------------------------------- //
    reg signed [1:0] buf_real [0:3];
    reg signed [1:0] buf_imag [0:3];
    reg [1:0] ptr;   // circular pointer 0..3

    wire signed [1:0] fb_real;
    wire signed [1:0] fb_imag;

    // Continuous assignments
    assign fb_real = buf_real[ptr];   // current S(n-4), real part
    assign fb_imag = buf_imag[ptr];   // current S(n-4), imag part
    // -------------------------------------------------------------- //
    // Simplified complex multiply:
    // (real_in + j*imag_in) * (fb_real + j*fb_imag)
    // Since real_in/imag_in are always one-hot +-1 (from qpsk_mapper),
    // the multiply reduces to sign flips / swaps, no real multiplier needed
    // -------------------------------------------------------------- //
    reg signed [1:0] mult_real;
    reg signed [1:0] mult_imag;

    always @(*) begin
        if (real_in == 2'sd1 && imag_in == 2'sd0) begin          // X = +1
            mult_real = fb_real;
            mult_imag = fb_imag;
        end else if (real_in == 2'sd0 && imag_in == 2'sd1) begin // X = +j
            mult_real = -fb_imag;
            mult_imag =  fb_real;
        end else if (real_in == 2'sd0 && imag_in == -2'sd1) begin // X = -j
            mult_real =  fb_imag;
            mult_imag = -fb_real;
        end else begin                                            // X = -1
            mult_real = -fb_real;
            mult_imag = -fb_imag;
        end
    end

    // -------------------------------------------------------------- //
    // Sequential: update output and buffer on every new symbol
    // -------------------------------------------------------------- //
    integer i;
    always @(posedge clk) begin
        if (!rst_n) begin
            // Initial value for all 4 delay-line slots = 1+j
            // (per standard: initial DQPSK feedback memory = exp(j*pi/4),
            // unnormalized as 1+j to match the unnormalized QPSK mapper)
            for (i = 0; i < 4; i = i + 1) begin
                buf_real[i] <= 2'sd1;
                buf_imag[i] <= 2'sd1;
            end
            ptr      <= 2'd0;
            real_out <= 2'sd1;
            imag_out <= 2'sd1;
        end else if (en) begin
            real_out <= mult_real;
            imag_out <= mult_imag;

            // Write the new result back into the same slot
            // (it will be reused as S(n-4) exactly 4 symbols later)
            buf_real[ptr] <= mult_real;
            buf_imag[ptr] <= mult_imag;

            ptr <= ptr + 2'd1;   // wraps automatically 0->1->2->3->0
        end
    end

endmodule