module sm_ram (
    input  wire       clk,       
    
    // Write Port 
    input  wire       en_w,      
    input  wire [7:0] wr_addr,   
    input  wire [3:0] data_in,   
    
    // Read Port 
    input  wire       en_r,      
    input  wire [7:0] rd_addr,   
    output reg  [3:0] data_out   
);

    // Memory array: Depth = 256, Width = 4 bits
    reg [3:0] mem [0:255];

    // Synchronous Write
    always @(posedge clk) begin
        if (en_w) begin
            mem[wr_addr] <= data_in;
        end
    end

    // Synchronous Read
    always @(posedge clk) begin
        if (en_r) begin
            data_out <= mem[rd_addr];
        end
    end

endmodule