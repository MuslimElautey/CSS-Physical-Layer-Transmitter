`timescale 10ns / 1ns
//======================================================================//
/*
Author : Ali Elbadry
Date Published : 9/7/2026
Last Modified : -
Project : CSS PHY LAYER IMPLEMENTATION
Module Description : test bench for the algorithm that counts no of padding zeros
*/
//==========================================================================//
//===========================Module Declaration=============================//
module mod3_algo_tb ();
//===========================Parameters Declaration=========================//
//===========================Input Declaration==============================//
//=========================Output Declaration============================//
//===========================Reg Declaration=============================//
reg i_rst;
reg i_clk;
reg	[7:0]	i_payloadlength;
reg	[7:0]	i_psdu_by_bytes;
//===========================Wire Declaration=============================//
wire	o_padded_phr_psdu;
//===========================combinational Logic=============================//
//===========================Module Instantiations===========================//
zero_padder zero_padder_dut (i_psdu_by_bytes,i_payloadlength,i_clk,i_rst,o_padded_phr_psdu);
//===========================Test Cases===========================//
initial
begin
i_payloadlength = 0;
#10
i_payloadlength = 1;
#10
i_payloadlength = 2;
#10
i_payloadlength = 3;
#10
i_payloadlength = 4;
#10
i_payloadlength = 5;
#10
i_payloadlength = 6;
#10
i_payloadlength = 7;
#10
i_payloadlength = 8;
#10
i_payloadlength = 9;
#10
i_payloadlength = 11;
#10
i_payloadlength = 12;
#10
i_payloadlength = 13;
end


//===========================End Of Module===================================//
endmodule










