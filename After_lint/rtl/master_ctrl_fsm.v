//////////////////////////////////////////////////////////////////////////////////
// Company: ITI
// Engineer: Mohab Elsayed
// 
// Create Date: 09/13/2026 05:10:57 PM
// Module Name: master_ctrl_fsm
// Project Name: Zigbee PHY TX

// Description: 
// The master controller for all the blocks in the Zigbee PHY transmitter that controls the complete operation.
//////////////////////////////////////////////////////////////////////////////////


module master_ctrl_fsm(
    input               clk,
    input               rst_n,
    
    // System Inputs
    input               i_start_tx,
    input      [7:0]    i_max_symbols,
    
    // Handshaking with qpsk_dqpsk_chirp_top
    input               i_ready_for_IQ,               //request from modulator
    input               i_done_mod,                   // Modulator has finished
    
    // Handshaking Outputs to qpsk_dqpsk_chirp_top
    output reg          o_modulator_start,            //enable for chirp modulation
    output reg          o_last_group,                 //tell the modulator if we are sending the last byte
    
    // Datapath Controls
    output reg          o_zp_en,                      //enable signal for zero padder
    output     [7:0]    o_sm_ram_rd_addr,             //address for symbol mapper ram
    output     [3:0]    o_preample_sfd_rom_rd_addr,   //address for for preample and sfd rom
    output reg          o_ppdu_sel,                   //selector for ppdu former : 1 = preample_sfd , 0 = sm ram data
    output reg          o_zp_mux_sel,                 //selector for zp mux : 1 = payload ram data , 0 = payload length
    output              o_ppdu_out_en,                //enable the outputs of the ppdu former
    output              o_ppdu_load,                  //read data from ram and rom into ppdu former
    output reg          o_done_tx                     
    );
 
    // ----------------------------------------------------
    // ----------------------------------------------------
    //    Internal Signals and State Machine Parameters  //
    // ----------------------------------------------------   
    // ----------------------------------------------------
    reg        [1:0]    current_state                , next_state ;
    reg        [7:0]    sm_ram_rd_addr_reg           , sm_ram_rd_addr_next ;
    reg        [3:0]    preample_sfd_rom_rd_addr_reg , preample_sfd_rom_rd_addr_next ;
    reg        [1:0]    req_cnt_reg                  , req_cnt_next ;
    reg        [1:0]    load_delay_reg               , load_delay_next ;
    reg                 ready_for_IQ_d; 
    wire                ready_pulse; 
    
    localparam     idle                   = 2'b00,
                   send_preample_sfd      = 2'b01,
                   send_payload           = 2'b10,
                   wait_mod_done          = 2'b11 ;
   
   // ----------------------------------------------------
   // ----------------------------------------------------
   //                    Registers                      //
   // ----------------------------------------------------
   // ---------------------------------------------------- 
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state                <= idle ;
            sm_ram_rd_addr_reg           <= 8'b0 ;
            preample_sfd_rom_rd_addr_reg <= 4'b0 ;
            req_cnt_reg                  <= 2'b0 ;
            load_delay_reg               <= 2'b0 ;
            ready_for_IQ_d               <= 1'b0 ;
        end
        else begin
            current_state                <= next_state ;
            sm_ram_rd_addr_reg           <= sm_ram_rd_addr_next ;
            preample_sfd_rom_rd_addr_reg <= preample_sfd_rom_rd_addr_next ;
            req_cnt_reg                  <= req_cnt_next ;
            load_delay_reg               <= load_delay_next ;
            ready_for_IQ_d               <= i_ready_for_IQ ;
        end
    end

    // ----------------------------------------------------
    // ----------------------------------------------------
    //                 Next state logic                  //
    // ----------------------------------------------------
    // ----------------------------------------------------    
    
    assign ready_pulse = i_ready_for_IQ & ~ready_for_IQ_d;
    
    
    //Delay 2 clock cycles after changing the ram and rom address before loading their data into the PPDU former to make sure the data is valid
    always @(*) begin
        load_delay_next[0] = (ready_pulse && (req_cnt_reg == 2'd3));
        load_delay_next[1] = load_delay_reg[0];
    end
    
    always @(*) begin
        next_state                    = current_state ;
        o_zp_en                       = 1'b0 ;
        o_ppdu_sel                    = 1'b0 ;
        o_done_tx                     = 1'b0 ;
        sm_ram_rd_addr_next           = sm_ram_rd_addr_reg ;
        preample_sfd_rom_rd_addr_next = preample_sfd_rom_rd_addr_reg ;
        o_modulator_start             = 1'b0 ;
        req_cnt_next                  = req_cnt_reg ;
        o_last_group                  = 1'b0 ;
        o_zp_mux_sel                  = 1'b1 ;
        
        case (current_state) 
            idle :              begin
                                    sm_ram_rd_addr_next           = 8'b0 ;
                                    preample_sfd_rom_rd_addr_next = 4'b0 ;
                                    o_zp_mux_sel                  = 1'b0 ;
                                    
                                    if (i_start_tx) begin
                                        next_state                = send_preample_sfd ;
                                        o_zp_en                   = 1'b1 ;
                                        o_modulator_start         = 1'b1 ;
                                        o_ppdu_sel                = 1'b1 ;
                                    end
                                end
                                
            send_preample_sfd : begin
                                    o_ppdu_sel       = 1'b1 ;
                                    
                                    if (ready_pulse) begin 
                                        req_cnt_next = req_cnt_reg + 1'b1;
                                    
                                        if (req_cnt_reg == 2'd3) begin 
                                            req_cnt_next = 1'b0;
                                            
                                            if (preample_sfd_rom_rd_addr_reg == 4'd11) begin 
                                                next_state                    = send_payload;
                                                o_ppdu_sel                    = 1'b0 ;
                                                req_cnt_next                  = 1'b0;
                                            end 
                                            else begin
                                                preample_sfd_rom_rd_addr_next = preample_sfd_rom_rd_addr_reg + 1'b1;
                                            end
                                        end
                                    end
                                end
                                
            send_payload :      begin
                                    o_ppdu_sel       = 1'b0; 
                                    
                                    if (o_sm_ram_rd_addr == i_max_symbols - 1'b1) begin
                                        o_last_group = 1'b1;
                                    end
                                    
                                    if (ready_pulse) begin
                                        req_cnt_next = req_cnt_reg + 1'b1;
                                        
                                        if (req_cnt_reg == 2'd3) begin
                                            req_cnt_next = 1'b0;
                                            
                                            if (sm_ram_rd_addr_reg == i_max_symbols - 1'b1) begin
                                                next_state          = wait_mod_done;
                                                req_cnt_next        = 1'b0;
                                            end else begin
                                                sm_ram_rd_addr_next = sm_ram_rd_addr_reg + 1'b1;
                                            end
                                        end
                                    end
                                end
                                
            wait_mod_done :     begin
                                    o_ppdu_sel     = 1'b1; 
                                    
                                    if (i_done_mod) begin
                                        o_done_tx  = 1'b1;
                                        next_state = idle;
                                    end
                                    
                                end
                                
            default :           begin
                                    next_state                    = current_state ;
                                    o_zp_en                       = 1'b0 ;
                                    o_ppdu_sel                    = 1'b0 ;
                                    o_done_tx                     = 1'b0 ;
                                    sm_ram_rd_addr_next           = sm_ram_rd_addr_reg ;
                                    preample_sfd_rom_rd_addr_next = preample_sfd_rom_rd_addr_reg ;
                                    o_modulator_start             = 1'b0 ;
                                    req_cnt_next                  = req_cnt_reg ;
                                    o_last_group                  = 1'b0 ;
                                end                
        endcase
    end

    // ----------------------------------------------------
    // ----------------------------------------------------
    //                    Output Logic                   //
    // ----------------------------------------------------   
    // ----------------------------------------------------
    assign o_preample_sfd_rom_rd_addr = preample_sfd_rom_rd_addr_reg ;
    assign o_sm_ram_rd_addr           = sm_ram_rd_addr_reg ;
    assign o_ppdu_out_en              = ready_pulse ;
    assign o_ppdu_load                = i_start_tx | load_delay_reg[1];          //Load ram and rom data into the PPDU former at start or after 2 cycles from changing the address

endmodule
