module css_symbols_rom #(parameter ADDR_WIDTH = 8, parameter DATA_WIDTH = 6)(
    input [ADDR_WIDTH-1:0] addr,
    output signed [DATA_WIDTH-1:0] data_out_r,
    output signed [DATA_WIDTH-1:0] data_out_i
);

    reg [DATA_WIDTH-1:0] rom_r [0:2**ADDR_WIDTH-1];
    reg [DATA_WIDTH-1:0] rom_i [0:2**ADDR_WIDTH-1];

    initial begin
        $readmemb ("chirpSequenceReal_tofile.txt", rom_r);
        $readmemb ("chirpSequenceImag_tofile.txt", rom_i);
    end

    assign data_out_r = rom_r[addr];
    assign data_out_i = rom_i[addr];

endmodule
