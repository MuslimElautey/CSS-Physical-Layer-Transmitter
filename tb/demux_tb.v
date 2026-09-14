`timescale 10ns / 1ns
//======================================================================//
/*
Author : Ali Elbadry
Date Published : 13/9/2026
Last Modified : -
Project : CSS PHY LAYER IMPLEMENTATION
Module Description : demux test bench
*/
//==========================================================================//
//===========================Module Declaration=============================//
module demux_tb();
//===========================Parameters Declaration=========================//
//===========================Integers Declaration=========================//
integer i;
integer k;
integer j;
integer ind_I;
integer ind_Q;
integer error_count;

//===========================Input Declaration==============================//		
//=========================Output Declaration===============================//
//===========================Reg Declaration================================//
reg 		i_serial;			//serial bits coming from zero padder		
reg 		i_invalid_bit;		//invalid signal coming from the zero padder
reg			i_rstn;
reg			i_clk;	

reg			serial_data [0:21];
reg			expected_I [0:10];
reg			expected_Q [0:10];
reg			delivered_I [0:10];
reg			delivered_Q [0:10];
//===========================Wire Declaration===============================//
wire 		o_Q;				//a bit Output to be paseed to the symbol mapper
wire		o_I;				//a bit Output to be paseed to the symbol mapper
wire		o_valid_I;
wire		o_valid_Q;
//===========================Sequential Logic===============================//
//===========================Module Instantiations==========================//
demux demux_dut (i_serial	,i_invalid_bit	,i_rstn	,i_clk	,o_I	,o_valid_I	,o_Q	,o_valid_Q	);
//===========================Test Cases=====================================//
initial 
	begin
		i_clk = 0;
		forever
			#5 i_clk = ~i_clk;
	end
	
initial 
	begin
		$readmemb ("../../test_vectors/demux/serial_data.txt",serial_data);
		$readmemb ("../../test_vectors/demux/expected_I_gap.txt",expected_I);
		$readmemb ("../../test_vectors/demux/expected_Q_gap.txt",expected_Q);
	end
	
	
initial
	begin
		i_rstn = 0;
		i_invalid_bit = 1;
		i = 0;
		ind_I =0;
		ind_Q = 0;
		error_count = 0;
		@(posedge i_clk);
		@(posedge i_clk)
			begin
				i_rstn = 1;
				i_invalid_bit = 0;
			end
		
		while (i < 22)
			begin
				i_serial = serial_data [i];
				@(posedge i_clk);
				if (o_valid_I)
					begin
						delivered_I[ind_I] = o_I;
						ind_I = ind_I +1;
					end
				else if (o_valid_Q)
					begin
						delivered_Q[ind_Q] = o_Q;
						ind_Q = ind_Q +1;
					end 
				i = i +1;
				
				if (i == 10)
					i_invalid_bit = 1;
				else if (i == 11)				//tests invalid mid reading but gives mismatches
					i_invalid_bit = 0;
				
			end		
for (k = 0; k < 11; k= k+1)
		begin
			if (expected_I[k] ^ delivered_I[k])
				begin
					$display ("mismatch (I): bit index =%d",
													k);
					error_count = error_count +1;
				end
			else
				$display ("matched (I): bit index =%d",
													k);		
		end
for (j = 0; j < 10;j= j+1)
		begin
			
			if (expected_Q[j] ^ delivered_Q[j])
				begin
					$display ("mismatch (Q): bit index =%d",
													j);
					error_count = error_count +1;
				end
			else
				$display ("matched (Q): bit index =%d",
													j);		
		end
	
if (!error_count)
	$display ("test succeded");
else
	$display ("test failed");
	
	$stop;
	end
//===========================End Of Module==================================//
endmodule
