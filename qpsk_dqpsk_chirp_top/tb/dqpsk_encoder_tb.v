module dqpsk_encoder_tb;
    reg clk=0, rst_n=0, en=0;
    reg signed [1:0] real_in, imag_in;
    wire signed [1:0] real_out, imag_out;

    dqpsk_encoder dut(.clk(clk), .rst_n(rst_n), .en(en),
                       .real_in(real_in), .imag_in(imag_in),
                       .real_out(real_out), .imag_out(imag_out));

    always #5 clk = ~clk;

    initial begin
        rst_n=0; en=0; #12;
        rst_n=1; en=1;
        // X1=j, X2=1, X3=-j, X4=-1 (matches the manual numeric example)
        real_in=0; imag_in=1;  #10;  // expected S1 = j*(1+j)   = -1+j
        real_in=1; imag_in=0;  #10;  // expected S2 = 1*(1+j)   =  1+j
        real_in=0; imag_in=-1; #10;  // expected S3 = -j*(1+j)  =  1-j
        real_in=-1;imag_in=0;  #10;  // expected S4 = -1*(1+j)  = -1-j
        real_in=1; imag_in=0;  #10;  // expected S5 = X5*S1 = 1*(-1+j) = -1+j
        $stop;
    end

    initial $monitor("t=%0t real_out=%d imag_out=%d", $time, real_out, imag_out);
endmodule