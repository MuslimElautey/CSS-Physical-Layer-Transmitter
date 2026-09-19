module preamble_sfd_rom #(
parameter ADDR_WIDTH = 4,
parameter DATA_WIDTH = 4
)(
    input clk,
    input [ADDR_WIDTH-1:0] addr,
    output  [DATA_WIDTH-1:0] data
);

    reg [DATA_WIDTH-1:0] rom [0:(2**ADDR_WIDTH)-1];

    initial begin
        rom[0] = 4'b1111;
        rom[1] = 4'b1111;
        rom[2] = 4'b1111;
        rom[3] = 4'b1111;
        rom[4] = 4'b1111;
        rom[5] = 4'b1111;
        rom[6] = 4'b1111;
        rom[7] = 4'b1111;
        rom[8] = 4'b0111;
        rom[9] = 4'b0100;
        rom[10] = 4'b1001;
        rom[11] = 4'b1100;
        rom[12] = 4'b0000;
        rom[13] = 4'b0000;
        rom[14] = 4'b0000;
        rom[15] = 4'b0000;
    end
	
        assign data = rom[addr];

endmodule