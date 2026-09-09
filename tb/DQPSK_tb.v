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


initial begin
    rstn = 0;
    en = 1;
    X_real = 2'b01; X_imag = 2'b00;
    repeat (5) @(negedge clk);
    rstn = 1;
    X_real = 2'b01; X_imag = 2'b00;
    repeat (5) @(negedge clk);
    X_real = 2'b00; X_imag = 2'b01;
    repeat (5) @(negedge clk);
    X_real = 2'b11; X_imag = 2'b00;
    repeat (5) @(negedge clk);
    X_real = 2'b00; X_imag = 2'b11;
    repeat (5) @(negedge clk);
    $finish;
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
