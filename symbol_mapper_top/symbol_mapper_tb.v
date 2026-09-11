module tb_symbol_mapper_top();

    reg        I;         
    reg        valid_I;
    reg  [7:0] rd_addr;
    reg        en_r;
    reg        clk;
    reg        rstn;        
    wire [3:0] data_out;

    symbol_mapper_top DUT (
        .I        (I),
        .valid_I  (valid_I),
        .rd_addr  (rd_addr),
        .en_r     (en_r),
        .data_out (data_out),
        .clk      (clk),
        .rstn     (rstn)   
    );

    always #5 clk = ~clk;

    initial begin
        clk     = 0;
        rstn    = 0;        
        I       = 0;
        valid_I = 0;
        rd_addr = 8'd0;
        en_r    = 0;

        @(negedge clk);
        @(negedge clk);
        rstn = 1;           
        @(negedge clk);

        // WRITE test
        
        //  input 3'b001 -> Expected RAM output: 4'b1010 
        I = 0; valid_I = 1; @(negedge clk); 
        I = 0; valid_I = 1; @(negedge clk); 
        I = 1; valid_I = 1; @(negedge clk); 
        valid_I = 0;
        @(negedge clk);

        //  input 3'b111 -> Expected RAM output: 4'b0110 
        I = 1; valid_I = 1; @(negedge clk); 
        I = 1; valid_I = 1; @(negedge clk); 
        I = 1; valid_I = 1; @(negedge clk); 
        valid_I = 0;
        @(negedge clk);
        @(negedge clk);

        //testing valid_I  -> Expected RAM output: 4'b0011
         I = 1; valid_I = 1; @(negedge clk); 
        I = 1; valid_I = 0; @(negedge clk); 
        I = 1; valid_I = 1; @(negedge clk); 
        I = 0; valid_I = 1; @(negedge clk); 
        valid_I = 0;
        @(negedge clk);
        @(negedge clk);


        // READ test
        en_r = 1;

        rd_addr = 0;
        @(negedge clk);

        rd_addr = 1;
        @(negedge clk);

        rd_addr = 2;
        @(negedge clk);

        en_r = 0;
        @(negedge clk);
        @(negedge clk);


        $stop;
    end

endmodule