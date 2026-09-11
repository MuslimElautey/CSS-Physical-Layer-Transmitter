module qpsk_mapper_tb (
);

reg I_bit, Q_bit;
wire signed [1:0] X_real, X_imag;

qpsk_mapper dut (.I_bit(I_bit), .Q_bit(Q_bit), .X_real(X_real), .X_imag(X_imag));


initial begin
    I_bit = 0; Q_bit = 0;
    #10 I_bit = 1; Q_bit =0;
    #10 I_bit = 1; Q_bit =1;
    #10 I_bit = 0; Q_bit =1;
    #10 $stop;
end

endmodule
