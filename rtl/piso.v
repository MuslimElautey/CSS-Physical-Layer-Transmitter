module piso #(
    parameter DATA_WIDTH = 4
)(
    input clk,
    input load, //allow piso to load new bus of bits inside it
    input out_en, //allow piso to out the LSB
    input [DATA_WIDTH-1:0]in,
    output reg out,valid
);

reg [DATA_WIDTH-1:0]q; //inside register

always @(posedge clk) begin
    if(load)begin
        q<=in;
        valid<=0;
    end
    else if (out_en) begin
        valid<=1;
        {q[DATA_WIDTH-2:0],out}<=q; //shift right by 1 bit
    end
    else begin
        valid<=0;
    end
end

endmodule
