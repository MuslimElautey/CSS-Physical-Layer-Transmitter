module qpsk_mapper_tb;
    reg I, Q;
    wire signed [1:0] real_out, imag_out;

    qpsk_mapper dut (.I(I), .Q(Q), .real_out(real_out), .imag_out(imag_out));

    initial begin
        $monitor("I=%b Q=%b -> real=%d imag=%d", I, Q, real_out, imag_out);
        I=1; Q=1; #10;   //real=1  imag=0
        I=1; Q=0; #10;   //real=0  imag=-1
        I=0; Q=1; #10;   //real=0  imag=1
        I=0; Q=0; #10;   //real=-1 imag=0
        $stop;
    end
endmodule