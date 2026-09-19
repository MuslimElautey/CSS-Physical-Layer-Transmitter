module qpsk_mapper (
    input  wire              I,
    input  wire              Q,
    output wire signed [1:0] real_out,
    output wire signed [1:0] imag_out
);

    wire same = (I == Q);   // 1 (real path active)
    wire diff = ~same;      // 1 (imag path active)

    assign real_out = same ? (I ? 2'sd1 : -2'sd1) : 2'sd0;
    assign imag_out = diff ? (Q ? 2'sd1 : -2'sd1) : 2'sd0;

endmodule