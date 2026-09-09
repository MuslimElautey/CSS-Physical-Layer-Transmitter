module shift_reg #(parameter FF_num = 4 , parameter WIDTH = 2 ) (
    input [WIDTH-1:0]   D,
    input               clk,
    input               rstn,
    input               en,
    output [WIDTH-1:0]  Q
);
wire [WIDTH-1:0] Q_int [0:FF_num];       // To ensure that it's a array of 2-bit busses 
genvar i;

assign Q_int[0] = D;
assign Q = Q_int[FF_num];

generate
    for ( i = 0 ; i<FF_num ; i = i + 1 ) begin
        ff ff_inst (.D(Q_int[i]),
                    .clk(clk),
                    .rstn(rstn),
                    .en(en),
                    .Q(Q_int[i+1])
        );
    end
endgenerate

endmodule
