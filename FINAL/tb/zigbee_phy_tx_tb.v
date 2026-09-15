`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Mohab Elsayed
// 
// Create Date: 09/14/2026 
// Module Name: zigbee_phy_tx_tb
// Project Name: Zigbee PHY TX
// Description: Testbench for the Zigbee PHY TX top module. It reads the raw 
//              MAC payload from a text file, drives the DUT, and logs the 
//              Tx_real and Tx_imag outputs to files for MATLAB verification.
//////////////////////////////////////////////////////////////////////////////////

module zigbee_phy_tx_tb();
    
    // ----------------------------------------------------------------- //
    // 1. Module Ports & Signals
    // ----------------------------------------------------------------- //
    reg         clk; 
    reg         reset;            // Active-low
    reg         start_Tx;
    reg  [7:0]  payloadLength;
    reg  [7:0]  payload_din;
    reg  [7:0]  payload_addr;
    reg         payload_wr_en;
    
    wire        done_Tx;
    wire [7:0]  Tx_real;
    wire [7:0]  Tx_imag;
    
    real half_clk_period = 15.625; // 32 MHz clock
    
    // ----------------------------------------------------------------- //
    // 2. File I/O Variables
    // ----------------------------------------------------------------- //
    reg [7:0]   mac_payload_mem [0:24]; // Memory to hold the 25 bytes from MATLAB
    integer     file_real, file_imag, i;
        
    // ----------------------------------------------------------------- //
    // 3. Module Instantiation
    // ----------------------------------------------------------------- //
    zigbee_phy_tx dut (
        .clk             (clk),
        .reset           (reset),
        .start_Tx        (start_Tx),
        .payloadLength   (payloadLength),
        .payload_din     (payload_din),
        .payload_addr    (payload_addr),
        .payload_wr_en   (payload_wr_en),
        .done_Tx         (done_Tx),
        .Tx_real         (Tx_real),
        .Tx_imag         (Tx_imag)
    );

    // ----------------------------------------------------------------- //
    // 4. Clock Generation
    // ----------------------------------------------------------------- //
    always #(half_clk_period) clk = ~clk;

    // ----------------------------------------------------------------- //
    // 5. Input Stimulus & File Operations
    // ----------------------------------------------------------------- //
    initial begin
        // Open files for writing the RTL output
        file_real = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_real.txt", "w");
        file_imag = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_imag.txt", "w");


        // Initial Values
        clk           = 0;
        start_Tx      = 0;
        payloadLength = 0;
        payload_din   = 0;
        payload_addr  = 0;
        payload_wr_en = 0;
        
        // Apply System Reset
        apply_reset();
        
        // Read the randomly generated RAW MAC payload from MATLAB
        $display("Reading MAC Payload from mac_payload_raw.txt...");
        $readmemb("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/mac_payload_raw.txt", mac_payload_mem);
        
        // Write the 25 bytes into the Payload RAM
        payloadLength = 25;
        for (i = 0; i < 25; i = i + 1) begin
            write_payload_byte(i[7:0], mac_payload_mem[i]);
        end
        
        repeat(2) @(negedge clk); // Synchronize before starting TX
        
        // Trigger Transmission
        $display("Starting Transmission for 25 bytes...");
        trigger_tx();
        
        // Wait for Transmission to Complete
        wait(done_Tx == 1'b1);
        $display("Transmission Completed Successfully!");
        
        repeat(10) @(negedge clk);
        
        // Close output files
        $fclose(file_real);
        $fclose(file_imag);
        
        $stop;
    end

    // ----------------------------------------------------------------- //
    // 6. Output Sampling
    // ----------------------------------------------------------------- //
    always @(posedge clk) begin
        // We only write to the text file when the Modulator outputs a valid sample.
        if (dut.u_mod_top.sample_valid) begin 
            // Write signed decimal values to match MATLAB's output format
            $fdisplay(file_real, "%d", $signed(Tx_real));
            $fdisplay(file_imag, "%d", $signed(Tx_imag));
        end
    end

    // ----------------------------------------------------------------- //
    // 7. Tasks
    // ----------------------------------------------------------------- //
    task apply_reset;
        begin
            reset = 0; 
            @(negedge clk) reset = 1;
        end
    endtask
    
    task write_payload_byte;
        input [7:0] address;
        input [7:0] data;
        begin
            payload_wr_en = 1'b1;
            payload_addr  = address;
            payload_din   = data;
            
            @(negedge clk);
            payload_wr_en = 1'b0;
        end
    endtask
    
    task trigger_tx;
        begin
            start_Tx      = 1'b1;
            
            @(negedge clk);
            start_Tx      = 1'b0;
        end
    endtask

endmodule