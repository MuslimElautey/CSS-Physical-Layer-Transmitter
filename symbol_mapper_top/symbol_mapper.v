module symbol_mapper (
    input  wire       clk,       // Clock signal for the counter
    input  wire       rst,       // Reset signal to clear the address counter
    input  wire       valid_in,  // From DEMUX (valid_I or valid_Q)
    input  wire [2:0] data_in,   // 3-bit input from DEMUX (replaces 'addr' in your image)
    
    output reg  [3:0] data_out,  // 4-bit mapped output to SM RAM
    output wire       en_w,      // Write enable for SM RAM
    output reg  [7:0] wr_addr    // Write address for SM RAM
);

    // 1. Combinational ROM: Data mapping (Walsh-Hadamard 1Mbps)
    always @(*) begin
        case (data_in)
            3'b000: data_out = 4'b1111;
            3'b001: data_out = 4'b1010;
            3'b010: data_out = 4'b1100;
            3'b011: data_out = 4'b1001;
            3'b100: data_out = 4'b0000;
            3'b101: data_out = 4'b0101;
            3'b110: data_out = 4'b0011;
            3'b111: data_out = 4'b0110;
            default: data_out = 4'b0000; // Safe default
        endcase
    end

    // 2. Write Enable Control
    // The RAM will only write when DEMUX says the 3-bits are valid
    assign en_w = valid_in; 

    // 3. Sequential Counter: Write Address Generation
    // Increments the address automatically every time a valid write occurs
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_addr <= 9'd0;
        end else if (valid_in) begin
            wr_addr <= wr_addr + 1'b1;
        end
    end

endmodule