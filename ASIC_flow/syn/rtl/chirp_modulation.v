// ===================================================================
// Module: chirp_modulation
// Implements chirpModulation.m: multiplies each of 4 subchirps (38
// samples each) by one DQPSK symbol Sn, then outputs Tgap zero samples.
// Fixed for 1 Mbps, chirpIndex = 1 (Teven=10, Todd=70).
// ===================================================================
module chirp_modulation (
    input  wire              clk,
    input  wire              rst_n,
    input  wire              start,        // pulse: begin new packet
    input  wire              last_group,   // held valid at each group's sn_req: 1 if this is the final group
    input  wire signed [1:0] sn_real,      // +-1 only
    input  wire signed [1:0] sn_imag,      // +-1 only
    input  wire              sn_valid,     // pulse: sn_real/sn_imag valid
    output reg               sn_req,       // pulse: request next Sn
    output reg  signed [7:0] Tx_real,
    output reg  signed [7:0] Tx_imag,
    output reg               sample_valid, // 1 while Tx_real/Tx_imag carry an output sample
    output reg               done_mod      // pulse: last group's gap finished
);

    localparam TSUB      = 38;
    localparam TGAP_EVEN = 10;
    localparam TGAP_ODD  = 70;

    // Chirp ROM: 4 subchirps x 38 samples, 6-bit signed, loaded from files
    reg signed [5:0] chirp_real_rom [0:255];
    reg signed [5:0] chirp_imag_rom [0:255];
    
     always @(*) begin
        chirp_real_rom[0] = 6'b000000;
        chirp_real_rom[1] = 6'b000001;
        chirp_real_rom[2] = 6'b111110;
        chirp_real_rom[3] = 6'b110101;
        chirp_real_rom[4] = 6'b111100;
        chirp_real_rom[5] = 6'b010100;
        chirp_real_rom[6] = 6'b010100;
        chirp_real_rom[7] = 6'b110101;
        chirp_real_rom[8] = 6'b100001;
        chirp_real_rom[9] = 6'b101111;
        chirp_real_rom[10] = 6'b001110;
        chirp_real_rom[11] = 6'b011110;
        chirp_real_rom[12] = 6'b010100;
        chirp_real_rom[13] = 6'b111010;
        chirp_real_rom[14] = 6'b100100;
        chirp_real_rom[15] = 6'b100010;
        chirp_real_rom[16] = 6'b110001;
        chirp_real_rom[17] = 6'b000111;
        chirp_real_rom[18] = 6'b011000;
        chirp_real_rom[19] = 6'b011111;
        chirp_real_rom[20] = 6'b011001;
        chirp_real_rom[21] = 6'b001100;
        chirp_real_rom[22] = 6'b111101;
        chirp_real_rom[23] = 6'b101111;
        chirp_real_rom[24] = 6'b100110;
        chirp_real_rom[25] = 6'b100001;
        chirp_real_rom[26] = 6'b100001;
        chirp_real_rom[27] = 6'b100011;
        chirp_real_rom[28] = 6'b100110;
        chirp_real_rom[29] = 6'b101010;
        chirp_real_rom[30] = 6'b101101;
        chirp_real_rom[31] = 6'b110000;
        chirp_real_rom[32] = 6'b110011;
        chirp_real_rom[33] = 6'b110101;
        chirp_real_rom[34] = 6'b111000;
        chirp_real_rom[35] = 6'b111010;
        chirp_real_rom[36] = 6'b111100;
        chirp_real_rom[37] = 6'b111111;
        chirp_real_rom[38] = 6'b000000;
        chirp_real_rom[39] = 6'b111111;
        chirp_real_rom[40] = 6'b111100;
        chirp_real_rom[41] = 6'b111010;
        chirp_real_rom[42] = 6'b111000;
        chirp_real_rom[43] = 6'b110101;
        chirp_real_rom[44] = 6'b110011;
        chirp_real_rom[45] = 6'b110000;
        chirp_real_rom[46] = 6'b101101;
        chirp_real_rom[47] = 6'b101010;
        chirp_real_rom[48] = 6'b100110;
        chirp_real_rom[49] = 6'b100011;
        chirp_real_rom[50] = 6'b100001;
        chirp_real_rom[51] = 6'b100001;
        chirp_real_rom[52] = 6'b100110;
        chirp_real_rom[53] = 6'b101111;
        chirp_real_rom[54] = 6'b111101;
        chirp_real_rom[55] = 6'b001100;
        chirp_real_rom[56] = 6'b011001;
        chirp_real_rom[57] = 6'b011111;
        chirp_real_rom[58] = 6'b011000;
        chirp_real_rom[59] = 6'b000111;
        chirp_real_rom[60] = 6'b110001;
        chirp_real_rom[61] = 6'b100010;
        chirp_real_rom[62] = 6'b100100;
        chirp_real_rom[63] = 6'b111010;
        chirp_real_rom[64] = 6'b010100;
        chirp_real_rom[65] = 6'b011110;
        chirp_real_rom[66] = 6'b001110;
        chirp_real_rom[67] = 6'b101111;
        chirp_real_rom[68] = 6'b100001;
        chirp_real_rom[69] = 6'b110101;
        chirp_real_rom[70] = 6'b010100;
        chirp_real_rom[71] = 6'b010100;
        chirp_real_rom[72] = 6'b111100;
        chirp_real_rom[73] = 6'b110101;
        chirp_real_rom[74] = 6'b111110;
        chirp_real_rom[75] = 6'b000001;
        chirp_real_rom[76] = 6'b000000;
        chirp_real_rom[77] = 6'b000001;
        chirp_real_rom[78] = 6'b111110;
        chirp_real_rom[79] = 6'b110101;
        chirp_real_rom[80] = 6'b111100;
        chirp_real_rom[81] = 6'b010100;
        chirp_real_rom[82] = 6'b010100;
        chirp_real_rom[83] = 6'b110101;
        chirp_real_rom[84] = 6'b100001;
        chirp_real_rom[85] = 6'b101111;
        chirp_real_rom[86] = 6'b001110;
        chirp_real_rom[87] = 6'b011110;
        chirp_real_rom[88] = 6'b010100;
        chirp_real_rom[89] = 6'b111010;
        chirp_real_rom[90] = 6'b100100;
        chirp_real_rom[91] = 6'b100010;
        chirp_real_rom[92] = 6'b110001;
        chirp_real_rom[93] = 6'b000111;
        chirp_real_rom[94] = 6'b011000;
        chirp_real_rom[95] = 6'b011111;
        chirp_real_rom[96] = 6'b011001;
        chirp_real_rom[97] = 6'b001100;
        chirp_real_rom[98] = 6'b111101;
        chirp_real_rom[99] = 6'b101111;
        chirp_real_rom[100] = 6'b100110;
        chirp_real_rom[101] = 6'b100001;
        chirp_real_rom[102] = 6'b100001;
        chirp_real_rom[103] = 6'b100011;
        chirp_real_rom[104] = 6'b100110;
        chirp_real_rom[105] = 6'b101010;
        chirp_real_rom[106] = 6'b101101;
        chirp_real_rom[107] = 6'b110000;
        chirp_real_rom[108] = 6'b110011;
        chirp_real_rom[109] = 6'b110101;
        chirp_real_rom[110] = 6'b111000;
        chirp_real_rom[111] = 6'b111010;
        chirp_real_rom[112] = 6'b111100;
        chirp_real_rom[113] = 6'b111111;
        chirp_real_rom[114] = 6'b000000;
        chirp_real_rom[115] = 6'b111111;
        chirp_real_rom[116] = 6'b111100;
        chirp_real_rom[117] = 6'b111010;
        chirp_real_rom[118] = 6'b111000;
        chirp_real_rom[119] = 6'b110101;
        chirp_real_rom[120] = 6'b110011;
        chirp_real_rom[121] = 6'b110000;
        chirp_real_rom[122] = 6'b101101;
        chirp_real_rom[123] = 6'b101010;
        chirp_real_rom[124] = 6'b100110;
        chirp_real_rom[125] = 6'b100011;
        chirp_real_rom[126] = 6'b100001;
        chirp_real_rom[127] = 6'b100001;
        chirp_real_rom[128] = 6'b100110;
        chirp_real_rom[129] = 6'b101111;
        chirp_real_rom[130] = 6'b111101;
        chirp_real_rom[131] = 6'b001100;
        chirp_real_rom[132] = 6'b011001;
        chirp_real_rom[133] = 6'b011111;
        chirp_real_rom[134] = 6'b011000;
        chirp_real_rom[135] = 6'b000111;
        chirp_real_rom[136] = 6'b110001;
        chirp_real_rom[137] = 6'b100010;
        chirp_real_rom[138] = 6'b100100;
        chirp_real_rom[139] = 6'b111010;
        chirp_real_rom[140] = 6'b010100;
        chirp_real_rom[141] = 6'b011110;
        chirp_real_rom[142] = 6'b001110;
        chirp_real_rom[143] = 6'b101111;
        chirp_real_rom[144] = 6'b100001;
        chirp_real_rom[145] = 6'b110101;
        chirp_real_rom[146] = 6'b010100;
        chirp_real_rom[147] = 6'b010100;
        chirp_real_rom[148] = 6'b111100;
        chirp_real_rom[149] = 6'b110101;
        chirp_real_rom[150] = 6'b111110;
        chirp_real_rom[151] = 6'b000001;
        chirp_real_rom[152] = 6'b000000;
        chirp_real_rom[153] = 6'b000000;
        chirp_real_rom[154] = 6'b000000;
        chirp_real_rom[155] = 6'b000000;
        chirp_real_rom[156] = 6'b000000;
        chirp_real_rom[157] = 6'b000000;
        chirp_real_rom[158] = 6'b000000;
        chirp_real_rom[159] = 6'b000000;
        chirp_real_rom[160] = 6'b000000;
        chirp_real_rom[161] = 6'b000000;
        chirp_real_rom[162] = 6'b000000;
        chirp_real_rom[163] = 6'b000000;
        chirp_real_rom[164] = 6'b000000;
        chirp_real_rom[165] = 6'b000000;
        chirp_real_rom[166] = 6'b000000;
        chirp_real_rom[167] = 6'b000000;
        chirp_real_rom[168] = 6'b000000;
        chirp_real_rom[169] = 6'b000000;
        chirp_real_rom[170] = 6'b000000;
        chirp_real_rom[171] = 6'b000000;
        chirp_real_rom[172] = 6'b000000;
        chirp_real_rom[173] = 6'b000000;
        chirp_real_rom[174] = 6'b000000;
        chirp_real_rom[175] = 6'b000000;
        chirp_real_rom[176] = 6'b000000;
        chirp_real_rom[177] = 6'b000000;
        chirp_real_rom[178] = 6'b000000;
        chirp_real_rom[179] = 6'b000000;
        chirp_real_rom[180] = 6'b000000;
        chirp_real_rom[181] = 6'b000000;
        chirp_real_rom[182] = 6'b000000;
        chirp_real_rom[183] = 6'b000000;
        chirp_real_rom[184] = 6'b000000;
        chirp_real_rom[185] = 6'b000000;
        chirp_real_rom[186] = 6'b000000;
        chirp_real_rom[187] = 6'b000000;
        chirp_real_rom[188] = 6'b000000;
        chirp_real_rom[189] = 6'b000000;
        chirp_real_rom[190] = 6'b000000;
        chirp_real_rom[191] = 6'b000000;
        chirp_real_rom[192] = 6'b000000;
        chirp_real_rom[193] = 6'b000000;
        chirp_real_rom[194] = 6'b000000;
        chirp_real_rom[195] = 6'b000000;
        chirp_real_rom[196] = 6'b000000;
        chirp_real_rom[197] = 6'b000000;
        chirp_real_rom[198] = 6'b000000;
        chirp_real_rom[199] = 6'b000000;
        chirp_real_rom[200] = 6'b000000;
        chirp_real_rom[201] = 6'b000000;
        chirp_real_rom[202] = 6'b000000;
        chirp_real_rom[203] = 6'b000000;
        chirp_real_rom[204] = 6'b000000;
        chirp_real_rom[205] = 6'b000000;
        chirp_real_rom[206] = 6'b000000;
        chirp_real_rom[207] = 6'b000000;
        chirp_real_rom[208] = 6'b000000;
        chirp_real_rom[209] = 6'b000000;
        chirp_real_rom[210] = 6'b000000;
        chirp_real_rom[211] = 6'b000000;
        chirp_real_rom[212] = 6'b000000;
        chirp_real_rom[213] = 6'b000000;
        chirp_real_rom[214] = 6'b000000;
        chirp_real_rom[215] = 6'b000000;
        chirp_real_rom[216] = 6'b000000;
        chirp_real_rom[217] = 6'b000000;
        chirp_real_rom[218] = 6'b000000;
        chirp_real_rom[219] = 6'b000000;
        chirp_real_rom[220] = 6'b000000;
        chirp_real_rom[221] = 6'b000000;
        chirp_real_rom[222] = 6'b000000;
        chirp_real_rom[223] = 6'b000000;
        chirp_real_rom[224] = 6'b000000;
        chirp_real_rom[225] = 6'b000000;
        chirp_real_rom[226] = 6'b000000;
        chirp_real_rom[227] = 6'b000000;
        chirp_real_rom[228] = 6'b000000;
        chirp_real_rom[229] = 6'b000000;
        chirp_real_rom[230] = 6'b000000;
        chirp_real_rom[231] = 6'b000000;
        chirp_real_rom[232] = 6'b000000;
        chirp_real_rom[233] = 6'b000000;
        chirp_real_rom[234] = 6'b000000;
        chirp_real_rom[235] = 6'b000000;
        chirp_real_rom[236] = 6'b000000;
        chirp_real_rom[237] = 6'b000000;
        chirp_real_rom[238] = 6'b000000;
        chirp_real_rom[239] = 6'b000000;
        chirp_real_rom[240] = 6'b000000;
        chirp_real_rom[241] = 6'b000000;
        chirp_real_rom[242] = 6'b000000;
        chirp_real_rom[243] = 6'b000000;
        chirp_real_rom[244] = 6'b000000;
        chirp_real_rom[245] = 6'b000000;
        chirp_real_rom[246] = 6'b000000;
        chirp_real_rom[247] = 6'b000000;
        chirp_real_rom[248] = 6'b000000;
        chirp_real_rom[249] = 6'b000000;
        chirp_real_rom[250] = 6'b000000;
        chirp_real_rom[251] = 6'b000000;
        chirp_real_rom[252] = 6'b000000;
        chirp_real_rom[253] = 6'b000000;
        chirp_real_rom[254] = 6'b000000;
        chirp_real_rom[255] = 6'b000000;
    end
 
    always @(*) begin
        chirp_imag_rom[0] = 6'b000000;
        chirp_imag_rom[1] = 6'b111111;
        chirp_imag_rom[2] = 6'b111011;
        chirp_imag_rom[3] = 6'b000000;
        chirp_imag_rom[4] = 6'b010000;
        chirp_imag_rom[5] = 6'b001010;
        chirp_imag_rom[6] = 6'b101101;
        chirp_imag_rom[7] = 6'b100011;
        chirp_imag_rom[8] = 6'b111101;
        chirp_imag_rom[9] = 6'b011010;
        chirp_imag_rom[10] = 6'b011011;
        chirp_imag_rom[11] = 6'b000011;
        chirp_imag_rom[12] = 6'b101000;
        chirp_imag_rom[13] = 6'b100001;
        chirp_imag_rom[14] = 6'b110000;
        chirp_imag_rom[15] = 6'b001001;
        chirp_imag_rom[16] = 6'b011011;
        chirp_imag_rom[17] = 6'b011110;
        chirp_imag_rom[18] = 6'b010010;
        chirp_imag_rom[19] = 6'b000000;
        chirp_imag_rom[20] = 6'b101110;
        chirp_imag_rom[21] = 6'b100011;
        chirp_imag_rom[22] = 6'b100001;
        chirp_imag_rom[23] = 6'b100101;
        chirp_imag_rom[24] = 6'b101110;
        chirp_imag_rom[25] = 6'b111000;
        chirp_imag_rom[26] = 6'b000010;
        chirp_imag_rom[27] = 6'b001011;
        chirp_imag_rom[28] = 6'b010001;
        chirp_imag_rom[29] = 6'b010110;
        chirp_imag_rom[30] = 6'b011001;
        chirp_imag_rom[31] = 6'b011010;
        chirp_imag_rom[32] = 6'b011000;
        chirp_imag_rom[33] = 6'b010100;
        chirp_imag_rom[34] = 6'b001110;
        chirp_imag_rom[35] = 6'b001000;
        chirp_imag_rom[36] = 6'b000011;
        chirp_imag_rom[37] = 6'b000000;
        chirp_imag_rom[38] = 6'b000000;
        chirp_imag_rom[39] = 6'b000000;
        chirp_imag_rom[40] = 6'b000011;
        chirp_imag_rom[41] = 6'b001000;
        chirp_imag_rom[42] = 6'b001110;
        chirp_imag_rom[43] = 6'b010100;
        chirp_imag_rom[44] = 6'b011000;
        chirp_imag_rom[45] = 6'b011010;
        chirp_imag_rom[46] = 6'b011001;
        chirp_imag_rom[47] = 6'b010110;
        chirp_imag_rom[48] = 6'b010001;
        chirp_imag_rom[49] = 6'b001011;
        chirp_imag_rom[50] = 6'b000010;
        chirp_imag_rom[51] = 6'b111000;
        chirp_imag_rom[52] = 6'b101110;
        chirp_imag_rom[53] = 6'b100101;
        chirp_imag_rom[54] = 6'b100001;
        chirp_imag_rom[55] = 6'b100011;
        chirp_imag_rom[56] = 6'b101110;
        chirp_imag_rom[57] = 6'b000000;
        chirp_imag_rom[58] = 6'b010010;
        chirp_imag_rom[59] = 6'b011110;
        chirp_imag_rom[60] = 6'b011011;
        chirp_imag_rom[61] = 6'b001001;
        chirp_imag_rom[62] = 6'b110000;
        chirp_imag_rom[63] = 6'b100001;
        chirp_imag_rom[64] = 6'b101000;
        chirp_imag_rom[65] = 6'b000011;
        chirp_imag_rom[66] = 6'b011011;
        chirp_imag_rom[67] = 6'b011010;
        chirp_imag_rom[68] = 6'b111101;
        chirp_imag_rom[69] = 6'b100011;
        chirp_imag_rom[70] = 6'b101101;
        chirp_imag_rom[71] = 6'b001010;
        chirp_imag_rom[72] = 6'b010000;
        chirp_imag_rom[73] = 6'b000000;
        chirp_imag_rom[74] = 6'b111011;
        chirp_imag_rom[75] = 6'b111111;
        chirp_imag_rom[76] = 6'b000000;
        chirp_imag_rom[77] = 6'b000000;
        chirp_imag_rom[78] = 6'b000100;
        chirp_imag_rom[79] = 6'b111111;
        chirp_imag_rom[80] = 6'b101111;
        chirp_imag_rom[81] = 6'b110101;
        chirp_imag_rom[82] = 6'b010010;
        chirp_imag_rom[83] = 6'b011100;
        chirp_imag_rom[84] = 6'b000010;
        chirp_imag_rom[85] = 6'b100101;
        chirp_imag_rom[86] = 6'b100100;
        chirp_imag_rom[87] = 6'b111100;
        chirp_imag_rom[88] = 6'b010111;
        chirp_imag_rom[89] = 6'b011110;
        chirp_imag_rom[90] = 6'b001111;
        chirp_imag_rom[91] = 6'b110110;
        chirp_imag_rom[92] = 6'b100100;
        chirp_imag_rom[93] = 6'b100001;
        chirp_imag_rom[94] = 6'b101101;
        chirp_imag_rom[95] = 6'b000000;
        chirp_imag_rom[96] = 6'b010001;
        chirp_imag_rom[97] = 6'b011100;
        chirp_imag_rom[98] = 6'b011110;
        chirp_imag_rom[99] = 6'b011010;
        chirp_imag_rom[100] = 6'b010001;
        chirp_imag_rom[101] = 6'b000111;
        chirp_imag_rom[102] = 6'b111101;
        chirp_imag_rom[103] = 6'b110100;
        chirp_imag_rom[104] = 6'b101110;
        chirp_imag_rom[105] = 6'b101001;
        chirp_imag_rom[106] = 6'b100110;
        chirp_imag_rom[107] = 6'b100101;
        chirp_imag_rom[108] = 6'b100111;
        chirp_imag_rom[109] = 6'b101011;
        chirp_imag_rom[110] = 6'b110001;
        chirp_imag_rom[111] = 6'b110111;
        chirp_imag_rom[112] = 6'b111100;
        chirp_imag_rom[113] = 6'b111111;
        chirp_imag_rom[114] = 6'b000000;
        chirp_imag_rom[115] = 6'b111111;
        chirp_imag_rom[116] = 6'b111100;
        chirp_imag_rom[117] = 6'b110111;
        chirp_imag_rom[118] = 6'b110001;
        chirp_imag_rom[119] = 6'b101011;
        chirp_imag_rom[120] = 6'b100111;
        chirp_imag_rom[121] = 6'b100101;
        chirp_imag_rom[122] = 6'b100110;
        chirp_imag_rom[123] = 6'b101001;
        chirp_imag_rom[124] = 6'b101110;
        chirp_imag_rom[125] = 6'b110100;
        chirp_imag_rom[126] = 6'b111101;
        chirp_imag_rom[127] = 6'b000111;
        chirp_imag_rom[128] = 6'b010001;
        chirp_imag_rom[129] = 6'b011010;
        chirp_imag_rom[130] = 6'b011110;
        chirp_imag_rom[131] = 6'b011100;
        chirp_imag_rom[132] = 6'b010001;
        chirp_imag_rom[133] = 6'b000000;
        chirp_imag_rom[134] = 6'b101101;
        chirp_imag_rom[135] = 6'b100001;
        chirp_imag_rom[136] = 6'b100100;
        chirp_imag_rom[137] = 6'b110110;
        chirp_imag_rom[138] = 6'b001111;
        chirp_imag_rom[139] = 6'b011110;
        chirp_imag_rom[140] = 6'b010111;
        chirp_imag_rom[141] = 6'b111100;
        chirp_imag_rom[142] = 6'b100100;
        chirp_imag_rom[143] = 6'b100101;
        chirp_imag_rom[144] = 6'b000010;
        chirp_imag_rom[145] = 6'b011100;
        chirp_imag_rom[146] = 6'b010010;
        chirp_imag_rom[147] = 6'b110101;
        chirp_imag_rom[148] = 6'b101111;
        chirp_imag_rom[149] = 6'b111111;
        chirp_imag_rom[150] = 6'b000100;
        chirp_imag_rom[151] = 6'b000000;
        chirp_imag_rom[152] = 6'b000000;
        chirp_imag_rom[153] = 6'b000000;
        chirp_imag_rom[154] = 6'b000000;
        chirp_imag_rom[155] = 6'b000000;
        chirp_imag_rom[156] = 6'b000000;
        chirp_imag_rom[157] = 6'b000000;
        chirp_imag_rom[158] = 6'b000000;
        chirp_imag_rom[159] = 6'b000000;
        chirp_imag_rom[160] = 6'b000000;
        chirp_imag_rom[161] = 6'b000000;
        chirp_imag_rom[162] = 6'b000000;
        chirp_imag_rom[163] = 6'b000000;
        chirp_imag_rom[164] = 6'b000000;
        chirp_imag_rom[165] = 6'b000000;
        chirp_imag_rom[166] = 6'b000000;
        chirp_imag_rom[167] = 6'b000000;
        chirp_imag_rom[168] = 6'b000000;
        chirp_imag_rom[169] = 6'b000000;
        chirp_imag_rom[170] = 6'b000000;
        chirp_imag_rom[171] = 6'b000000;
        chirp_imag_rom[172] = 6'b000000;
        chirp_imag_rom[173] = 6'b000000;
        chirp_imag_rom[174] = 6'b000000;
        chirp_imag_rom[175] = 6'b000000;
        chirp_imag_rom[176] = 6'b000000;
        chirp_imag_rom[177] = 6'b000000;
        chirp_imag_rom[178] = 6'b000000;
        chirp_imag_rom[179] = 6'b000000;
        chirp_imag_rom[180] = 6'b000000;
        chirp_imag_rom[181] = 6'b000000;
        chirp_imag_rom[182] = 6'b000000;
        chirp_imag_rom[183] = 6'b000000;
        chirp_imag_rom[184] = 6'b000000;
        chirp_imag_rom[185] = 6'b000000;
        chirp_imag_rom[186] = 6'b000000;
        chirp_imag_rom[187] = 6'b000000;
        chirp_imag_rom[188] = 6'b000000;
        chirp_imag_rom[189] = 6'b000000;
        chirp_imag_rom[190] = 6'b000000;
        chirp_imag_rom[191] = 6'b000000;
        chirp_imag_rom[192] = 6'b000000;
        chirp_imag_rom[193] = 6'b000000;
        chirp_imag_rom[194] = 6'b000000;
        chirp_imag_rom[195] = 6'b000000;
        chirp_imag_rom[196] = 6'b000000;
        chirp_imag_rom[197] = 6'b000000;
        chirp_imag_rom[198] = 6'b000000;
        chirp_imag_rom[199] = 6'b000000;
        chirp_imag_rom[200] = 6'b000000;
        chirp_imag_rom[201] = 6'b000000;
        chirp_imag_rom[202] = 6'b000000;
        chirp_imag_rom[203] = 6'b000000;
        chirp_imag_rom[204] = 6'b000000;
        chirp_imag_rom[205] = 6'b000000;
        chirp_imag_rom[206] = 6'b000000;
        chirp_imag_rom[207] = 6'b000000;
        chirp_imag_rom[208] = 6'b000000;
        chirp_imag_rom[209] = 6'b000000;
        chirp_imag_rom[210] = 6'b000000;
        chirp_imag_rom[211] = 6'b000000;
        chirp_imag_rom[212] = 6'b000000;
        chirp_imag_rom[213] = 6'b000000;
        chirp_imag_rom[214] = 6'b000000;
        chirp_imag_rom[215] = 6'b000000;
        chirp_imag_rom[216] = 6'b000000;
        chirp_imag_rom[217] = 6'b000000;
        chirp_imag_rom[218] = 6'b000000;
        chirp_imag_rom[219] = 6'b000000;
        chirp_imag_rom[220] = 6'b000000;
        chirp_imag_rom[221] = 6'b000000;
        chirp_imag_rom[222] = 6'b000000;
        chirp_imag_rom[223] = 6'b000000;
        chirp_imag_rom[224] = 6'b000000;
        chirp_imag_rom[225] = 6'b000000;
        chirp_imag_rom[226] = 6'b000000;
        chirp_imag_rom[227] = 6'b000000;
        chirp_imag_rom[228] = 6'b000000;
        chirp_imag_rom[229] = 6'b000000;
        chirp_imag_rom[230] = 6'b000000;
        chirp_imag_rom[231] = 6'b000000;
        chirp_imag_rom[232] = 6'b000000;
        chirp_imag_rom[233] = 6'b000000;
        chirp_imag_rom[234] = 6'b000000;
        chirp_imag_rom[235] = 6'b000000;
        chirp_imag_rom[236] = 6'b000000;
        chirp_imag_rom[237] = 6'b000000;
        chirp_imag_rom[238] = 6'b000000;
        chirp_imag_rom[239] = 6'b000000;
        chirp_imag_rom[240] = 6'b000000;
        chirp_imag_rom[241] = 6'b000000;
        chirp_imag_rom[242] = 6'b000000;
        chirp_imag_rom[243] = 6'b000000;
        chirp_imag_rom[244] = 6'b000000;
        chirp_imag_rom[245] = 6'b000000;
        chirp_imag_rom[246] = 6'b000000;
        chirp_imag_rom[247] = 6'b000000;
        chirp_imag_rom[248] = 6'b000000;
        chirp_imag_rom[249] = 6'b000000;
        chirp_imag_rom[250] = 6'b000000;
        chirp_imag_rom[251] = 6'b000000;
        chirp_imag_rom[252] = 6'b000000;
        chirp_imag_rom[253] = 6'b000000;
        chirp_imag_rom[254] = 6'b000000;
        chirp_imag_rom[255] = 6'b000000;
    end

    localparam S_IDLE=2'b00, S_REQ=2'b01, S_STREAM=2'b10, S_GAP=2'b11;
    reg [1:0] state;

    reg [1:0] subchirp_idx;   // 0..3
    reg [5:0] sample_idx;     // 0..37
    reg [6:0] gap_cnt;
    reg       group_parity;   // 0=even group, 1=odd group
    reg       last_group_lat;
    reg signed [1:0] sr, si;  // latched Sn

    wire [7:0] rom_addr = subchirp_idx*TSUB + sample_idx;
    wire signed [5:0] c_re = chirp_real_rom[rom_addr];
    wire signed [5:0] c_im = chirp_imag_rom[rom_addr];


// sr, si are each +-1 (2'sd1 or -2'sd1), never 0
wire signed [6:0] c_re_sr = sr[1] ? -c_re : c_re;   // c_re * sr
wire signed [6:0] c_im_si = si[1] ? -c_im : c_im;   // c_im * si
wire signed [6:0] c_re_si = si[1] ? -c_re : c_re;   // c_re * si
wire signed [6:0] c_im_sr = sr[1] ? -c_im : c_im;   // c_im * sr

wire signed [7:0] mult_real = c_re_sr - c_im_si;    // c_re*sr - c_im*si
wire signed [7:0] mult_imag = c_re_si + c_im_sr;    // c_re*si + c_im*sr

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= S_IDLE; sn_req <= 0; sample_valid <= 0; done_mod <= 0;
            Tx_real <= 0; Tx_imag <= 0;
            subchirp_idx <= 0; sample_idx <= 0; gap_cnt <= 0; group_parity <= 0;
        end else begin
            sn_req       <= 0;
            sample_valid <= 0;
            done_mod     <= 0;

            case (state)
                S_IDLE: begin
                    if (start) begin
                        subchirp_idx <= 0; group_parity <= 0;
                        sn_req <= 1; state <= S_REQ;
                    end
                end

                S_REQ: begin
                    if (sn_valid) begin
                        sr <= sn_real; si <= sn_imag;
                        if (subchirp_idx == 0) last_group_lat <= last_group;
                        sample_idx <= 0;
                        state <= S_STREAM;
						sn_req <= 0;
                    end else begin
                        sn_req <= 1; // keep requesting until valid
                    end
                end

                S_STREAM: begin
                    Tx_real      <= mult_real;
                    Tx_imag      <= mult_imag;
                    sample_valid <= 1;
                    if (sample_idx == TSUB-1) begin
                        if (subchirp_idx == 3) begin
                            gap_cnt <= (group_parity ? TGAP_ODD : TGAP_EVEN) - 1;
                            state   <= S_GAP;
                        end else begin
                            subchirp_idx <= subchirp_idx + 1'b1;
                            sn_req <= 1;
                            state  <= S_REQ;
                        end
                    end else begin
                        sample_idx <= sample_idx + 1'b1;
                    end
                end

                S_GAP: begin
                    Tx_real      <= 0;
                    Tx_imag      <= 0;
                    sample_valid <= 1;
                    if (gap_cnt == 0) begin
                        if (last_group_lat) begin
                            done_mod <= 1;
                            state    <= S_IDLE;
                        end else begin
                            group_parity <= ~group_parity;
                            subchirp_idx <= 0;
                            sn_req <= 1;
                            state  <= S_REQ;
                        end
                    end else begin
                        gap_cnt <= gap_cnt - 1'b1;
                    end
                end
            endcase
        end
    end
endmodule


