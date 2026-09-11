
module tb_symbol_mapper_top();

    reg  [2:0] I;
    reg        valid_I;
    reg  [7:0] rd_addr;
    reg        en_r;
    reg        clk;
    reg        rst;
    wire [3:0] data_out;

    // Instantiate Design Under Test (DUT)
    symbol_mapper_top DUT (
        .I        (I),
        .valid_I  (valid_I),
        .rd_addr  (rd_addr),
        .en_r     (en_r),
        .data_out (data_out),
        .clk      (clk),
        .rst      (rst)
    );

    // Clock Generation: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // 1. Initialize Inputs
        clk     = 0;
        rst     = 1;
        I       = 3'b000;
        valid_I = 0;
        rd_addr = 8'd0;
        en_r    = 0;

        // 2. Reset Sequence
        @(negedge clk);
        @(negedge clk);
        rst = 0;
        @(negedge clk);

        // 3. WRITE PHASE (Driving inputs at negedge clk)
        // Symbol 0: input 3'b000 -> Expected mapped output: 4'b1111
        I = 3'b000; 
        valid_I = 0;
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        valid_I = 1;
        @(negedge clk);
        valid_I = 0;
        @(negedge clk);

        // Symbol 1: input 3'b001 -> Expected mapped output: 4'b1010
        I = 3'b001; 
        valid_I = 1;
        @(negedge clk);
        valid_I = 0;
        @(negedge clk);

        // Symbol 2: input 3'b111 -> Expected mapped output: 4'b0110
        I = 3'b111; 
        valid_I = 1;
        @(negedge clk);
        valid_I = 0;
         @(negedge clk);
         @(negedge clk);

        // 4. READ PHASE (Driving read signals at negedge clk)
        en_r = 1;

        // Read Address 0 (Should display 4'b1111 on data_out)
        rd_addr = 0;
        @(negedge clk);

        // Read Address 1 (Should display 4'b1010 on data_out)
        rd_addr = 1;
        @(negedge clk);

        // Read Address 2 (Should display 4'b0110 on data_out)
        rd_addr = 2;
        @(negedge clk);

        en_r = 0;
         @(negedge clk);
         @(negedge clk);

        $display("Simulation finished successfully.");
        $stop;
    end

endmodule