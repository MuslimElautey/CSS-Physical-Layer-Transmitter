module piso #(
    parameter DATA_WIDTH = 4
)(
    input clk,
    input load, //allow piso to load new bus of bits inside it
    input out_en, //allow piso to out the LSB
    input [DATA_WIDTH-1:0]in,
    output reg out
);

reg [DATA_WIDTH-1:0]q; //inside register

always @(posedge clk) begin
    if(load)begin
        q<=in;
    end
    else if (out_en) begin
        {q[DATA_WIDTH-2:0],out}<=q; //shift right by 1 bit
    end
end

endmodule
