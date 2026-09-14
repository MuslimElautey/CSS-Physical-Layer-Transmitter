`timescale 10ns / 1ns
//======================================================================//
/*
Author : Ali Elbadry
Date Published : 12/9/2026
Last Modified : -
Project : CSS PHY LAYER IMPLEMENTATION
Module Description : zero_padder tb
*/
//==========================================================================//
//===========================Module Declaration=============================//
module zero_padder_tb ();
//===========================Parameters Declaration=========================//
parameter 			no_of_expected_bits = 1032;
parameter 			payloadlength = 127;
//===========================Integers Declaration=========================//
integer i;
integer k;
integer error_count;
//===========================Input Declaration==============================//
//=========================Output Declaration============================//
//===========================Reg Declaration=============================//
reg		[7:0]		test_vectors		[0:126];
reg 				i_rst;
reg 				i_start;
reg 				i_clk;
reg		[7:0]		i_payloadlength_data;
reg		[7:0]		payload_length;
reg					select;						// -high for data -low for length
reg					delivered_bits 				[0:no_of_expected_bits-1];
reg					expected_bits 				[0:no_of_expected_bits-1];
//===========================Wire Declaration=============================//
wire				o_serial;
wire				o_done;
wire				o_invalid_bit;
wire	[6:0]		o_ram_address;
//===========================combinational Logic=============================//
assign i_payloadlength_data = select ? test_vectors [o_ram_address] : payload_length;
//===========================Module Instantiations===========================//
zero_padder zero_padder_dut (i_payloadlength_data	,i_start	,i_clk	,i_rst	,o_done	,o_serial	,o_invalid_bit	,o_ram_address);
//===========================Test Cases===========================//
initial
	begin
		i_clk =0;
			forever
				#5
				i_clk = ~i_clk;
	end

//-----------------------------------------------------------------------------//
initial
	begin
		$readmemb ("../payload/payload.txt",test_vectors);
		$readmemb ("../payload/expected_bits_L127.txt",expected_bits);
	end
//-----------------------------------------------------------------------------//

initial
	begin
		error_count = 0;
		i = 0;
		i_rst = 0;
		select = 0;
		@(posedge i_clk);
		@(negedge i_clk)	
		i_rst = 1;
		@(posedge i_clk)
		payload_length = payloadlength;
		@(negedge i_clk)
		i_start = 1;
		@(posedge i_clk);
		@(posedge i_clk) begin
		select = 1;
		i_start = 0;
		end
		while (!o_done)
			begin
				if (!o_invalid_bit)
						begin
							delivered_bits[i] = o_serial; 
							i = i +1;
						end	
				@(posedge i_clk);
			end
		for (k = 0; k < no_of_expected_bits ; k = k+1)
			begin
				if (delivered_bits [k] ^ expected_bits[k])
					begin
						$display ("mismatch : bit_ind=%d >>>>> got=%b >>>>>> expected=%b",
												k,		delivered_bits[k],		expected_bits[k]);
						error_count = error_count +1;						
					end
			end
		if (!error_count)
			$display ("SUCCESFUL Test : 127 payload");
		else
			$display ("FAILED TEST : 127 payload");
			
		$stop;
			
	end
//===========================End Of Module===================================//
endmodule
