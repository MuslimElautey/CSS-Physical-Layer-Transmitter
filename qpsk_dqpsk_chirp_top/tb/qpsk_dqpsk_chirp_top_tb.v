module qpsk_dqpsk_chirp_top_tb;

    reg clk, rst_n, start, last_group;
    reg I, Q, IQ_valid;
    wire ready_for_IQ, sample_valid, done_mod;
    wire signed [7:0] Tx_real, Tx_imag;

    qpsk_dqpsk_chirp_top dut (
        .clk(clk), .rst_n(rst_n), .start(start), .last_group(last_group),
        .I(I), .Q(Q), .IQ_valid(IQ_valid),
        .ready_for_IQ(ready_for_IQ),
        .Tx_real(Tx_real), .Tx_imag(Tx_imag),
        .sample_valid(sample_valid), .done_mod(done_mod)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        start = 0;
        last_group = 1;
        I = 0; Q = 0; IQ_valid = 0;

        // Reset
        #20 rst_n = 1;

        // Start the chain
        #10 start = 1;
        #10 start = 0;

        // Feed symbol 1: X1 = j  (I=0, Q=1)
        #10 I=0; Q=1; IQ_valid=1;
        #10 IQ_valid=0;

        // Feed symbol 2: X2 = 1  (I=1, Q=1)
        #400 I=1; Q=1; IQ_valid=1;
        #10 IQ_valid=0;

        // Feed symbol 3: X3 = -j (I=1, Q=0)
        #400 I=1; Q=0; IQ_valid=1;
        #10 IQ_valid=0;

        // Feed symbol 4: X4 = -1 (I=0, Q=0)
        #400 I=0; Q=0; IQ_valid=1;
        #10 IQ_valid=0;

        #2000;
        $display("Test finished");
        $stop;
    end

    // ---------------------------------------------------------------
    // Show every stage of the signal chain, every clock edge
    // ---------------------------------------------------------------
   always @(posedge clk) begin
    $display("t=%0t | I=%b Q=%b IQ_valid=%b | X(qpsk)=%d,%dj | S(dqpsk)=%d,%dj | sn_valid=%b sn_req=%b | Tx=%d,%dj valid=%b",
        $time,
        I, Q, IQ_valid,
        dut.x_real, dut.x_imag,
        dut.s_real, dut.s_imag,
        dut.sn_valid_d, dut.ready_for_IQ,
        Tx_real, Tx_imag, sample_valid
    );
end


 initial begin 
        $monitor("t=%0t  sample_idx=%d subchirp_idx=%d sn_req=%b   sample_valid=%b  done_mod=%b", $time, dut.u_chirp.sample_idx, dut.u_chirp.subchirp_idx, dut.u_chirp.sn_req, sample_valid, done_mod); 
        end
endmodule