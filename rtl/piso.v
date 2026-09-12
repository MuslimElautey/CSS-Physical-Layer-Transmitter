module piso #(
    parameter DATA_WIDTH = 4
)(
    input clk,rst,load,
    input [DATA_WIDTH-1:0]in,
    output reg out
);

reg [DATA_WIDTH-1:0]q;

always @(posedge clk) begin
    if(rst)begin
        q<=0;
        out<=0;
    end
    else if(load)begin
        q<=in;
    end
    else begin
        {q[DATA_WIDTH-2:0],out}<=q;
    end
end

endmodule