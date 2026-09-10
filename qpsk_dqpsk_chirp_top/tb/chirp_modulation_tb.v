// Simple testbench for chirp_modulation
// Beginner-friendly version: fixed timing, no while/if loop, no sn_req polling

module chirp_modulation_tb;

    reg clk;
    reg rst_n;
    reg start;
    reg last_group;
    reg signed [1:0] sn_real;
    reg signed [1:0] sn_imag;
    reg sn_valid;

    wire sn_req;
    wire sample_valid;
    wire done_mod;
    wire signed [7:0] Tx_real;
    wire signed [7:0] Tx_imag;

    chirp_modulation dut (
        .clk(clk), .rst_n(rst_n), .start(start),
        .last_group(last_group),
        .sn_real(sn_real), .sn_imag(sn_imag), .sn_valid(sn_valid),
        .sn_req(sn_req),
        .Tx_real(Tx_real), .Tx_imag(Tx_imag),
        .sample_valid(sample_valid), .done_mod(done_mod)
    );

    // Clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Init all signals
        clk = 0;
        rst_n = 0;
        start = 0;
        sn_valid = 0;
        sn_real = 0;
        sn_imag = 0;
        last_group = 1;   // only one group in this simple test

        // Reset
        #20 rst_n = 1;

        // Start the module
        #10 start = 1;
        #10 start = 0;

        // Feed symbol 1: S1 = 1+j
        #10 sn_real = 1;  sn_imag = 1;  sn_valid = 1;
        #10 sn_valid = 0;

        // Feed symbol 2: S2 = -1+j
        #400 sn_real = -1; sn_imag = 1;  sn_valid = 1;
        #10 sn_valid = 0;

        // Feed symbol 3: S3 = 1-j
        #400 sn_real = 1;  sn_imag = -1; sn_valid = 1;
        #10 sn_valid = 0;

        // Feed symbol 4: S4 = -1-j
        #400 sn_real = -1; sn_imag = -1; sn_valid = 1;
        #10 sn_valid = 0;

        // Wait for the module to finish streaming + gap
        #2000;

        $display("Test finished");
        $stop;
    end

    // Print output samples as they come out
    always @(posedge clk) begin
        if (sample_valid)
            $display("t=%0t  Tx_real=%d  Tx_imag=%d", $time, Tx_real, Tx_imag);
    end

    // Print when sn_req is raised (to check timing manually)
    always @(posedge clk) begin
        if (sn_req)
            $display("t=%0t  sn_req is HIGH", $time);
    end
    initial begin 
        $monitor("t=%0t  sample_idx=%d subchirp_idx=%d sn_req=%b   sample_valid=%b  done_mod=%b", $time, dut.sample_idx, dut.subchirp_idx, sn_req, sample_valid, done_mod); 
        end

endmodule