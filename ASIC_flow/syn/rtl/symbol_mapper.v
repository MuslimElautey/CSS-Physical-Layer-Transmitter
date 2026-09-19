module symbol_mapper (
    input         clk,       
    input         rstn,       
    input         valid_in,  
    input         I,         
    output reg  [3:0] data_out,  
    output reg        en_w,      
    output reg  [7:0] wr_addr    
);

    
    reg [1:0] bit_cnt;       
    reg [2:0] shift_reg;     
    
    wire [2:0] current_3bits;
    reg  [3:0] next_data;

 
    assign current_3bits = {shift_reg[1:0], I};

    // ROM
    always @(*) begin
        case (current_3bits)
            3'b000: next_data = 4'b1111;
            3'b001: next_data = 4'b1010;
            3'b010: next_data = 4'b1100;
            3'b011: next_data = 4'b1001;
            3'b100: next_data = 4'b0000;
            3'b101: next_data = 4'b0101;
            3'b110: next_data = 4'b0011;
            3'b111: next_data = 4'b0110;
            default: next_data = 4'b0000; 
        endcase
    end

   
    always @(posedge clk ) begin
        if (!rstn) begin
            bit_cnt   <= 0;
            shift_reg <= 0;
            data_out  <= 0;
            en_w      <= 0;
            wr_addr   <= 0;
        end else begin
            en_w <= 0;

            if (valid_in) begin
                shift_reg <= {shift_reg[1:0], I};

                if (bit_cnt == 2'd2) begin
                    bit_cnt  <= 0;
                    data_out <= next_data;
                    en_w     <= 1;         
                end else begin
                    bit_cnt <= bit_cnt + 1;
                end
            end

            if (en_w) begin
                wr_addr <= wr_addr + 1;
            end
        end
    end

endmodule