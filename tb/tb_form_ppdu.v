module tb_form_ppdu;

    parameter DATA_WIDTH = 4;
    parameter ADDR_WIDTH = 4;

    reg clk;
    reg out_en;
    reg load;
    reg sel;
    reg [DATA_WIDTH-1:0] I_data, Q_data;
    reg [ADDR_WIDTH-1:0] rom_addr;

    wire I, Q;
    wire Ivalid, Qvalid;

    // instantiate the DUT
    form_ppdu #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk(clk),
        .out_en(out_en),
        .load(load),
        .sel(sel),
        .I_data(I_data),
        .Q_data(Q_data),
        .rom_addr(rom_addr),
        .I(I),
        .Q(Q),
        .Ivalid(Ivalid),
        .Qvalid(Qvalid)
    );

    // clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz clock (10ns period)

    initial begin
        // initial values
        out_en   = 0;
        load     = 0;
        sel      = 1;      // ROM mode (preamble/SFD)
        I_data   = 4'b0000;
        Q_data   = 4'b0000;
        rom_addr = 4'd0;

        // ================= sel = 1 , address = 0 =================
        @(posedge clk); load = 1;
        @(posedge clk); load = 0; out_en = 1;   // pulse 1
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);              // wait 4 cycles, nothing happening

        @(posedge clk); out_en = 1;             // pulse 2
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 3
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 4
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        // ================= sel = 1 , address = 10 =================
        rom_addr = 4'd9;
        @(posedge clk); load = 1;
        @(posedge clk); load = 0; out_en = 1;   // pulse 1
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 2
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 3
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 4
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        // ================= sel = 0 , I/Q data set 1 =================
        sel    = 0;
        I_data = 4'b1010;
        Q_data = 4'b0101;
        @(posedge clk); load = 1;
        @(posedge clk); load = 0; out_en = 1;   // pulse 1
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 2
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 3
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 4
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        // ================= sel = 0 , I/Q data set 2 =================
        I_data = 4'b1100;
        Q_data = 4'b0011;
        @(posedge clk); load = 1;
        @(posedge clk); load = 0; out_en = 1;   // pulse 1
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 2
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 3
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        @(posedge clk); out_en = 1;             // pulse 4
        @(posedge clk); out_en = 0;
        repeat (4) @(posedge clk);

        $stop;
    end

    // simple monitor
    initial begin
        $monitor("time=%0t sel=%b load=%b out_en=%b | I=%b Q=%b | Ivalid=%b Qvalid=%b",
                   $time, sel, load, out_en, I, Q, Ivalid, Qvalid);
    end

endmodule
