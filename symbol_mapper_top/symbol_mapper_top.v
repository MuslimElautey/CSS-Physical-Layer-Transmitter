module symbol_mapper_top (
    input  wire [2:0] I,        
    input  wire       valid_I,
    input  wire [7:0] rd_addr,
    input  wire       en_r,
    output wire [3:0] data_out,
    input  wire       clk,
    input  wire       rst
);

    // Internal wires
    wire [3:0] SM_out;   
    wire       en_w;
    wire [7:0] wr_addr;

    // Symbol Mapper Instance
    symbol_mapper SM (
        .clk      (clk),
        .rst      (rst),
        .valid_in (valid_I),
        .data_in  (I),
        .data_out (SM_out),
        .en_w     (en_w),
        .wr_addr  (wr_addr)
    );

    // SM RAM Instance
    sm_ram SM_RAM (
        .clk      (clk),
        .en_w     (en_w),
        .wr_addr  (wr_addr),
        .data_in  (SM_out),
        .en_r     (en_r),
        .rd_addr  (rd_addr),
        .data_out (data_out)
    );

endmodule