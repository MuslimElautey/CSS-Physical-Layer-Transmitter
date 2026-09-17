`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Mohab Elsayed
// 
// Create Date: 09/14/2026 
// Module Name: zigbee_phy_tx_tb
// Project Name: Zigbee PHY TX
// Description: Testbench executing 3 sequential test cases (0B, 25B, 127B).
//              It dynamically loads a separate MAC payload text file for each 
//              test case and applies a hardware reset between packets.
//              
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
    wire        sample_valid;
    
    real half_clk_period = 15.625; // 32 MHz clock
    
    // ----------------------------------------------------------------- //
    // 2. File I/O Variables
    // ----------------------------------------------------------------- //
    reg [7:0]   mac_payload_mem [0:127]; // Memory to hold up to 127 bytes
    integer     file_real, file_imag, i;
    reg         sampling_en;             // To control when to write to files
        
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
        .Tx_imag         (Tx_imag),
        .sample_valid    (sample_valid)
    );

    // ----------------------------------------------------------------- //
    // 4. Clock Generation
    // ----------------------------------------------------------------- //
    always #(half_clk_period) clk = ~clk;

    // ----------------------------------------------------------------- //
    // 5. Input Stimulus & File Operations
    // ----------------------------------------------------------------- //
    initial begin
        // Initial Values
        clk           = 0;
        start_Tx      = 0;
        payloadLength = 0;
        payload_din   = 0;
        payload_addr  = 0;
        payload_wr_en = 0;
        sampling_en   = 0;
        
        // ================================================================= //
        // TEST CASE 1: 0 Bytes Payload
        // ================================================================= //
        $display("\n--- Starting Test Case 1: 0 Bytes ---");
        apply_reset(); 
        payloadLength = 0;
        
        file_real = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_real_0B.txt", "w");
        file_imag = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_imag_0B.txt", "w");
        
        sampling_en = 1;
        trigger_tx();
        wait(done_Tx == 1'b1);
        repeat(5) @(negedge clk); 
        sampling_en = 0;
        
        $fclose(file_real);
        $fclose(file_imag);
        $display("Test Case 1 Completed!");
        
        repeat(10) @(negedge clk);
        
        // ================================================================= //
        // TEST CASE 2: 25 Bytes Payload
        // ================================================================= //
        $display("\n--- Starting Test Case 2: 25 Bytes ---");
        apply_reset(); 
        payloadLength = 25;
        
        // Read the 25-byte payload file
        $readmemb("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/mac_payload_raw_25B.txt", mac_payload_mem);
        
        for (i = 0; i < 25; i = i + 1) begin
            write_payload_byte(i[7:0], mac_payload_mem[i]);
        end
        
        file_real = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_real_25B.txt", "w");
        file_imag = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_imag_25B.txt", "w");
        
        sampling_en = 1;
        trigger_tx();
        wait(done_Tx == 1'b1);
        repeat(5) @(negedge clk); 
        sampling_en = 0;
        
        $fclose(file_real);
        $fclose(file_imag);
        $display("Test Case 2 Completed!");
        
        repeat(10) @(negedge clk);
        
        // ================================================================= //
        // TEST CASE 3: 127 Bytes Payload (Corner Case)
        // ================================================================= //
        $display("\n--- Starting Test Case 3: 127 Bytes ---");
        apply_reset(); 
        payloadLength = 127;
        
        // Read the 127-byte payload file
        $readmemb("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/mac_payload_raw_127B.txt", mac_payload_mem);
        
        for (i = 0; i < 127; i = i + 1) begin
            write_payload_byte(i[7:0], mac_payload_mem[i]);
        end
        
        file_real = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_real_127B.txt", "w");
        file_imag = $fopen("C:/iti/Zigbee/project_1/project_1.srcs/sources_1/new/rtl_tx_imag_127B.txt", "w");
        
        sampling_en = 1;
        trigger_tx();
        wait(done_Tx == 1'b1);
        repeat(5) @(negedge clk); 
        sampling_en = 0;
        
        $fclose(file_real);
        $fclose(file_imag);
        $display("Test Case 3 Completed!");
        
        // ================================================================= //
        $display("\nAll test cases finished successfully!");
        $stop;
    end

    // ----------------------------------------------------------------- //
    // 6. Output Sampling
    // ----------------------------------------------------------------- //
    always @(posedge clk) begin
        if (sample_valid && sampling_en) begin 
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