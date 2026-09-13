module tb_form_ppdu;
 
    parameter DATA_WIDTH = 4;
    parameter ADDR_WIDTH = 4;
 
    reg clk, out_en, load, sel;
    reg [DATA_WIDTH-1:0] I_data, Q_data;
    reg [ADDR_WIDTH-1:0] rom_addr;
    wire I, Q;
 
    // DUT
    form_ppdu #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk),
        .out_en(out_en),
        .load(load),
        .sel(sel),
        .I_data(I_data),
        .Q_data(Q_data),
        .rom_addr(rom_addr),
        .I(I),
        .Q(Q)
    );
 
    // clock: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;
 
    initial begin
        $dumpfile("tb_form_ppdu.vcd");
        $dumpvars(0, tb_form_ppdu);
 
        // init
        out_en   = 0;
        load     = 0;
        sel      = 0;
        I_data   = 4'b1010;
        Q_data   = 4'b0101;
        rom_addr = 0;
 
        // ---------------------------------------------------------
        // Case 1: sel = 0 -> I_data/Q_data pass straight into PISO
        // (no ROM involved, no extra latency needed)
        // ---------------------------------------------------------
        @(negedge clk);
        load = 1;
        @(negedge clk);
        load = 0;
        out_en = 1;
        repeat (4) @(negedge clk);
        out_en = 0;
 
        // ---------------------------------------------------------
        // Case 2: sel = 1 -> word from ROM at rom_addr = 2 ("1111")
        // ROM is now synchronous: data updates on posedge clk one
        // cycle after addr is applied, so we wait an extra edge
        // before asserting load.
        // ---------------------------------------------------------
        sel      = 1;
        rom_addr = 2;
        @(posedge clk);   // addr sampled, rom.data registers next
        @(negedge clk);   // data now stable
        load = 1;
        @(negedge clk);
        load = 0;
        out_en = 1;
        repeat (4) @(negedge clk);
        out_en = 0;
 
        // ---------------------------------------------------------
        // Case 3: sel = 1 -> word from ROM at rom_addr = 9 ("0100")
        // ---------------------------------------------------------
        rom_addr = 9;
        @(posedge clk);
        @(negedge clk);
        load = 1;
        @(negedge clk);
        load = 0;
        out_en = 1;
        repeat (4) @(negedge clk);
        out_en = 0;
 
        #20;
        $finish;
    end
 
    // simple monitor (dut.rom_out lets us see the ROM word actually
    // latched into the muxes)
    initial begin
        $display(" time | sel load out_en | I_data Q_data rom_addr rom_out | I Q");
        $monitor("%5t |  %b    %b     %b   |  %b   %b    %2d       %b    | %b %b",
                  $time, sel, load, out_en, I_data, Q_data, rom_addr, dut.rom_out, I, Q);
    end
 
endmodule