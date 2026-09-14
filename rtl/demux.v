`timescale 10ns / 1ns
//======================================================================//
/*
Author : Ali Elbadry
Date Published : 13/9/2026
Project : CSS PHY LAYER IMPLEMENTATION
Module Description : splits the phr+psdu frame into I & Q paths
*/
//==========================================================================//
//===========================Module Declaration=============================//
module demux (i_serial	,i_invalid_bit	,i_rstn	,i_clk	,o_I	,o_valid_I	,o_Q	,o_valid_Q	);
//===========================Parameters Declaration=========================//
//===========================Input Declaration==============================//
input 		i_serial;			//serial bits coming from zero padder		
input 		i_invalid_bit;		//invalid signal coming from the zero padder
input		i_rstn;
input		i_clk;		
//=========================Output Declaration===============================//
output reg 		o_Q;				//a bit Output to be paseed to the symbol mapper
output reg 		o_I;				//a bit Output to be paseed to the symbol mapper
output reg		o_valid_I;
output reg		o_valid_Q;
//===========================Reg Declaration================================//
reg				even_bit;
//===========================Wire Declaration===============================//
//===========================Combinational Logic===============================//
always @ (posedge i_clk)
	begin
		if(!i_rstn)
			begin
				o_valid_I 				<= 0;
				o_valid_Q 				<= 0;
				o_I						<= 0;
				o_Q						<= 0;
				even_bit				<= 1;
			end
		else if (i_invalid_bit)
			begin
				o_valid_I 				<= 0;
				o_valid_Q 				<= 0;
			end
		else
			begin
				if (even_bit)
					begin
						o_I 			<= i_serial;
						o_valid_I 		<= 1;
						o_valid_Q 		<= 0;
						even_bit		<= ~even_bit;
					end
				else
					begin
						o_Q 			<= i_serial;
						o_valid_Q		<= 1;
						o_valid_I		<= 0;
						even_bit		<= ~even_bit;
					end
			end
	end
//===========================Module Instantiations==========================//
//===========================Test Cases=====================================//
//===========================End Of Module==================================//
endmodule
