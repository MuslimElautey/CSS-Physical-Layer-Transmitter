module ff #(parameter WIDTH = 2) (
    input [WIDTH-1:0]       D,
    input                   clk, rstn,en,
    output reg [WIDTH-1:0]  Q
);
    always @(posedge clk , negedge rstn) begin
        if (!rstn) begin
            Q <= 1;
        end
        else if (en) begin
            Q <= D;
        end
    end
endmodule
