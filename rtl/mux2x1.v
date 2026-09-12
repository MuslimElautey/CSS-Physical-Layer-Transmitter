module mux2x1(
    input [3:0] in0,in1,
    input s,
    output [3:0] out
);
    assign out =(s)? in1:in0;
endmodule