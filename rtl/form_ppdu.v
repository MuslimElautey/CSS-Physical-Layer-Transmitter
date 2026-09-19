module form_ppdu #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4
) (
    input clk,
    input out_en, //take the LSB as output
    input load,   //fill piso with new bus of bits
    input sel,    //0->take data ,1->take preamble,SFD
    input [DATA_WIDTH-1:0]I_data,Q_data,
    input [ADDR_WIDTH-1:0]rom_addr,
    output I,Q,
    output IQ_valid //set as high when I,Q updated and ready for transmission
);

    wire [DATA_WIDTH-1:0]I_mux_out,Q_mux_out,rom_out;
    wire Ivalid , Qvalid;
    
    assign IQ_valid = Ivalid && Qvalid ;
    mux2x1 #(.DATA_WIDTH(DATA_WIDTH)) I_mux (.in0(I_data),.in1(rom_out),.sel(sel),.out(I_mux_out));
    mux2x1 #(.DATA_WIDTH(DATA_WIDTH)) Q_mux (.in0(Q_data),.in1(rom_out),.sel(sel),.out(Q_mux_out));

    preamble_sfd_rom #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) rom_dut (
        .clk(clk),.addr(rom_addr),.data(rom_out));

    piso #(.DATA_WIDTH(DATA_WIDTH)) I_piso (.clk(clk),.load(load),.out_en(out_en),.in(I_mux_out),.out(I),.valid(Ivalid));
    piso #(.DATA_WIDTH(DATA_WIDTH)) Q_piso (.clk(clk),.load(load),.out_en(out_en),.in(Q_mux_out),.out(Q),.valid(Qvalid));

endmodule