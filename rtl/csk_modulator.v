module csk_modulator #(parameter ROM_DATA_WIDTH = 6, parameter TX_WIDTH = 8) (
    input  signed [1:0]                 S_r,
    input  signed [1:0]                 S_i,
    input  signed [ROM_DATA_WIDTH-1:0]  chirp_r,
    input  signed [ROM_DATA_WIDTH-1:0]  chirp_i,
    output signed [TX_WIDTH-1:0]        tx_r,
    output signed [TX_WIDTH-1:0]        tx_i
);

// Sign extending the chirp rom symbols to prevent negation overflow (-32 * -1 = +32 which can not be represented by only 6 signed bits)
wire signed [ROM_DATA_WIDTH:0] ext_chirp_r = chirp_r;
wire signed [ROM_DATA_WIDTH:0] ext_chirp_i = chirp_i;


// The inputs S_r and S_i can only be +1 or -1 so we can just use combinational logic to represent the multiplication
//   (S_r + j S_i) * (C_r + j C_i)
// = (S_r * C_r - S_i * C_i) + j (S_r * C_i + S_i * C_r) Then:
// Real Tx output = S_r * C_r - S_i * C_i
// Imag Tx output = S_r * C_i + S_i * C_r

// and while S_r & S_i can only be +1 or -1 -> we can model this as a multiplexer
reg signed [ROM_DATA_WIDTH:0] Sr_Cr, Si_Ci, Sr_Ci, Si_Cr;                          // Multiplication signals

always @(*) begin
    case ({S_r , S_i})
        // If both S inputs are 1's -> then the multiplication output should stay the same
        4'b01_01: begin
            Sr_Cr = ext_chirp_r;
            Si_Ci = ext_chirp_i;
            Sr_Ci = ext_chirp_i;
            Si_Cr = ext_chirp_r;
        end

        // If both S inputs are -1 -> then the multiplication output should be negated
        4'b11_11: begin
            Sr_Cr = -ext_chirp_r;
            Si_Ci = -ext_chirp_i;
            Sr_Ci = -ext_chirp_i;
            Si_Cr = -ext_chirp_r;
        end

        // S_r = +1 , S_i = -1
        4'b01_11: begin
            Sr_Cr = ext_chirp_r;
            Si_Ci = -ext_chirp_i;
            Sr_Ci = ext_chirp_i;
            Si_Cr = -ext_chirp_r;
        end

        // S_r = -1 , S_i = +1
        4'b11_01: begin
            Sr_Cr = -ext_chirp_r;
            Si_Ci = ext_chirp_i;
            Sr_Ci = -ext_chirp_i;
            Si_Cr = ext_chirp_r;
        end

        default: begin
            Sr_Cr = ext_chirp_r;
            Si_Ci = ext_chirp_i;
            Sr_Ci = ext_chirp_i;
            Si_Cr = ext_chirp_r;
        end
    endcase
end

// The final Tx output calculation
assign tx_r = Sr_Cr - Si_Ci;
assign tx_i = Sr_Ci + Si_Cr;

endmodule
