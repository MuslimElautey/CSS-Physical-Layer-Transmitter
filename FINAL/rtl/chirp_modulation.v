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
    reg signed [5:0] chirp_real_rom [0:151];
    reg signed [5:0] chirp_imag_rom [0:151];
    
    initial begin
        $readmemb("chirpSequenceReal_tofile.mem", chirp_real_rom);
        $readmemb("chirpSequenceImag_tofile.mem", chirp_imag_rom);
    end

    localparam S_IDLE=0, S_REQ=1, S_STREAM=2, S_GAP=3;
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
                    sn_req <= (state==S_REQ) ? sn_req : 0;
                    if (sn_valid) begin
                        sr <= sn_real; si <= sn_imag;
                        if (subchirp_idx == 0) last_group_lat <= last_group;
                        sample_idx <= 0;
                        state <= S_STREAM;
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
