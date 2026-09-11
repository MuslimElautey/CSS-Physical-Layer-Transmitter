module symbol_mapper_top (
    input        I,        
    input        valid_I,
    input  [7:0] rd_addr,
    input        en_r,
    output [3:0] data_out,
    input        clk,
    input        rstn
);

    // Internal Wires
    wire [3:0] SM_out;   
    wire       en_w;
    wire [7:0] wr_addr;

    // Symbol Mapper Instance
    symbol_mapper SM (
        .clk      (clk),
        .rstn     (rstn),    
        .valid_in (valid_I),
        .I        (I),        
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