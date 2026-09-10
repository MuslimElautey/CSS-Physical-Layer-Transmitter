module DQPSK_tb ();
    reg                 clk;
    reg                 rstn;
    reg                 en;
    reg signed  [1:0]   X_real;
    reg signed  [1:0]   X_imag;
    wire signed [1:0]   S_out_r;
    wire signed [1:0]   S_out_i;

initial begin
    clk = 0;
    forever #5 clk=~clk;
end

/*
initial begin
    rstn = 0;
    en = 1;
    X_real = 2'b01; X_imag = 2'b00;
    en = 1;
    @(negedge clk); en = 0;
    repeat (5) @(negedge clk);
    rstn = 1;
    X_real = 2'b01; X_imag = 2'b00;
    en = 1;
    @(negedge clk); en = 0;
    repeat (10) @(negedge clk);
    X_real = 2'b00; X_imag = 2'b01;
    en = 1;
    @(negedge clk); en = 0;
    repeat (5) @(negedge clk);
    X_real = 2'b11; X_imag = 2'b00;
    en = 1;
    @(negedge clk); en = 0;
    repeat (10) @(negedge clk);
    X_real = 2'b00; X_imag = 2'b11;
    en = 1;
    @(negedge clk); en = 0;
    repeat (10) @(negedge clk);
    $stop;
end
*/

initial begin
    // 1. Initialize and Reset
    rstn = 0;
    en = 0;
    X_real = 2'b01; X_imag = 2'b00;
    repeat (5) @(negedge clk);
    rstn = 1;
    repeat (2) @(negedge clk);

    // 2. Symbol 1 (X_n = 1) -> Multiplies by initial 1+j
    X_real = 2'b01; X_imag = 2'b00;
    en = 1; @(negedge clk); en = 0;
    repeat (37) @(negedge clk); // Wait duration of 1 subchirp

    // 3. Symbol 2 (X_n = j) -> Multiplies by initial 1+j
    X_real = 2'b00; X_imag = 2'b01;
    en = 1; @(negedge clk); en = 0;
    repeat (37) @(negedge clk);

    // 4. Symbol 3 (X_n = -1) -> Multiplies by initial 1+j
    X_real = 2'b11; X_imag = 2'b00;
    en = 1; @(negedge clk); en = 0;
    repeat (37) @(negedge clk);

    // 5. Symbol 4 (X_n = -j) -> Multiplies by initial 1+j
    X_real = 2'b00; X_imag = 2'b11;
    en = 1; @(negedge clk); en = 0;
    repeat (37) @(negedge clk);

    // 6. Symbol 5 (X_n = 1) -> CRITICAL TEST: Multiplies by Symbol 1's result
    X_real = 2'b01; X_imag = 2'b00;
    en = 1; @(negedge clk); en = 0;
    repeat (37) @(negedge clk);

    $stop;
end


DQPSK dut ( .clk(clk),
            .rstn(rstn),
            .en(en),
            .X_real(X_real),
            .X_imag(X_imag),
            .S_out_r(S_out_r),
            .S_out_i(S_out_i)
);



endmodule
