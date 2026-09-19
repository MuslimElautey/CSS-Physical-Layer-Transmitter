module sm_ram (
    input         clk,       
    
    // Write Port 
    input         en_w,      
    input   [7:0] wr_addr,   
    input   [3:0] data_in,   
    
    // Read Port 
    input       [7:0] rd_addr,   
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
        data_out <= mem[rd_addr];
    end

endmodule