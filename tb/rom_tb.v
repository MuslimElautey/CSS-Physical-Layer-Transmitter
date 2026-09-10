module rom_tb (
);

    localparam ADDR_WIDTH = 8;
    localparam DATA_WIDTH = 6;

    reg [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_out_r;
    wire [DATA_WIDTH-1:0] data_out_i;


    css_symbols_rom #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) dut (.addr(addr), .data_out_i(data_out_i), .data_out_r(data_out_r));

integer i ;

    initial begin
        addr = 0;
        for (i =0 ;i<160 ;i=i+1 ) begin
            #5;
            addr=addr+1;
        end
        #20;
        $finish;
    end


endmodule
