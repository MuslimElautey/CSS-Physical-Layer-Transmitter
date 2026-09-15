`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2026 05:13:06 PM
// Design Name: 
// Module Name: payload_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module payload_ram(
    input         clk,       

    // Write Port 
    input         en_w,      
    input   [7:0] wr_addr,   
    input   [7:0] data_in,   
    
    // Read Port 
    input       [7:0] rd_addr,   
    output   [7:0] data_out   
    );
    
    // Memory array: Depth = 127, Width = 8 bits
    reg [7:0] mem [0:127];
    
    // Synchronous Write
    always @(posedge clk) begin
        if (en_w) begin
            mem[wr_addr] <= data_in;
        end
    end
    
    // Synchronous Read
   // always @(posedge clk) begin
       assign data_out = mem[rd_addr];
    //end

endmodule
