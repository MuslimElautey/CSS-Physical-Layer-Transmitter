module preamble_sfd_rom #(
parameter ADDR_WIDTH = 4,
parameter DATA_WIDTH = 4
)(
    input clk,
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data
);

    reg [DATA_WIDTH-1:0] rom [0:(2**ADDR_WIDTH)-1];

    initial begin
        $readmemb("preambleSFD.mem",rom);
    end

    always @(posedge clk) begin
        data <= rom[addr];
    end

endmodule
