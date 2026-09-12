module ram #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 8
)(
    input clk,wr_en,
    input [ADDR_WIDTH-1:0] wr_addr,rd_addr,
    input [DATA_WIDTH-1:0] wr_data,
    output [DATA_WIDTH-1:0] rd_data
);

    reg [DATA_WIDTH-1:0] mem [0:(2**ADDR_WIDTH)-1];

    // ------------------ Write ------------------
    always @(posedge clk) begin
        if (wr_en) begin
            mem[wr_addr] <= wr_data;
        end
    end

    // ------------------ Read ------------------
    assign rd_data = mem[rd_addr];

endmodule