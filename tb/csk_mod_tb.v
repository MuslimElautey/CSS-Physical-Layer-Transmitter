module csk_mod_tb (
);
localparam ROM_DATA_WIDTH = 6 ;
localparam TX_WIDTH = 8;
localparam ADDR_WIDTH = 8 ;

reg  [ADDR_WIDTH-1:0]      addr;
reg  [1:0]                 S_r;
reg  [1:0]                 S_i;
wire [ROM_DATA_WIDTH-1:0]  chirp_r;
wire [ROM_DATA_WIDTH-1:0]  chirp_i;
wire [TX_WIDTH-1:0]        tx_r;
wire [TX_WIDTH-1:0]        tx_i;

integer i;

initial begin
    addr = 0;
    S_r = 2'b01; S_i = 2'b01;
    for (i =0 ;i<153 ;i=i+1 ) begin
        #5;
        addr=addr+1;
    end
    #20;

    addr = 0;
    S_r = 2'b01; S_i = 2'b11;
    for (i =0 ;i<153 ;i=i+1 ) begin
        #5;
        addr=addr+1;
    end
    #20;

    addr = 0;
    S_r = 2'b11; S_i = 2'b01;
    for (i =0 ;i<153 ;i=i+1 ) begin
        #5;
        addr=addr+1;
    end
    #20;

    addr = 0;
    S_r = 2'b11; S_i = 2'b11;
    for (i =0 ;i<153 ;i=i+1 ) begin
        #5;
        addr=addr+1;
    end
    #20;
    $stop;
end


css_symbols_rom #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(ROM_DATA_WIDTH)) rom_dut (
    .addr(addr),
    .data_out_r(chirp_r),
    .data_out_i(chirp_i)
);

csk_modulator #(.ROM_DATA_WIDTH(ROM_DATA_WIDTH), .TX_WIDTH(TX_WIDTH)) csk_dut (
    .S_r(S_r),
    .S_i(S_i),
    .chirp_i(chirp_i),
    .chirp_r(chirp_r),
    .tx_r(tx_r),
    .tx_i(tx_i)
);


endmodule
