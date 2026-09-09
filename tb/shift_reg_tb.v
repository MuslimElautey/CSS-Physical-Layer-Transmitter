module shift_reg_tb ();
localparam FF_num = 4 ;
localparam WIDTH = 2 ;

reg [WIDTH-1:0]     D;
reg                 clk;
reg                 rstn;
reg                 en;
wire [WIDTH-1:0]    Q;



shift_reg #(.FF_num(FF_num), .WIDTH(WIDTH)) dut (.D(D), .clk(clk), .rstn(rstn),.en(en), .Q(Q));

always begin
    #5 clk = ~clk;
end

initial begin
    clk =0;
    rstn =0;
    D = 0;
    en = 0;
    repeat (5) @(negedge clk);
    rstn = 1;
    D = 0;
    repeat (10) @(negedge clk);
    D = 3;
    repeat (10) @(negedge clk);
    en = 1;
    D = 0;
    repeat (10) @(negedge clk);
    D = 1;
    repeat (10) @(negedge clk);
    $finish;
end

initial begin
    $monitor("time= %t \t rstn = %b \t clk = %b \t D = %b \t Q = %b", $time, rstn, clk, D, Q);
end

endmodule
