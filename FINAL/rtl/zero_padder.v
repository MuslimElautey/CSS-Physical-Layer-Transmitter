`timescale 10ns / 1ns
//======================================================================//
/*
Author : Ali Elbadry
Date Published : 11/9/2026
Project : CSS PHY LAYER IMPLEMENTATION
Module Description : adds zeros at the LSB's of the Payload to make it divisable by [6]
*/
//==========================================================================//
//===========================Module Declaration=============================//
module zero_padder (i_payloadlength_data	,i_start	,i_clk	,i_rstn	,o_done	,o_serial	,o_recieved_start	,o_invalid_bit	,o_ram_address);
//===========================Parameters Declaration=========================//
parameter	idle 				= 2'b00,
			sending_phr 		= 2'b01,
			sending_payload		= 2'b10,		
			padding				= 2'b11;
//===========================Input Declaration==============================//
input		[7:0]	i_payloadlength_data;		//a byte that contains the data or payload length
input				i_start;					//signal to start sending the phr
input				i_clk; 
input				i_rstn;
//=========================Output Declaration============================//
output	reg			o_serial;
output 	reg			o_done;
output	reg			o_invalid_bit;
output	reg			o_recieved_start;
output	reg [6:0]	o_ram_address;				// used to count no of read payload bytes and also used as an address
//===========================Reg Declaration=============================//
reg	signed 	[3:0]	intermediate_calc;			//holds the intermediate value of the mod calculation
reg			[2:0]	no_of_zeros;
reg			[2:0]	latched_no_of_zeros;
reg			[7:0]	latched_payload_length;
reg			[7:0]	byte_holder;				//holds the payload length during processing
reg 		[1:0]	state;
reg			[3:0]	counter; 					// used to count bit sequence
//===========================Wire Declaration================================//
//===========================Sequential Logic================================//
always @ (posedge i_clk)
	begin
		if(!i_rstn)
			begin
								state					<= idle;
								counter					<= 0;
								o_ram_address			<= 0;
								o_done 					<= 0;
								o_invalid_bit 			<= 1;
								o_recieved_start		<= 0;
			end
		else
			begin
				case (state)
					idle 		:begin 
								counter					<= 0;
								o_ram_address			<= 0;
								o_done 					<= 0;
								o_recieved_start		<= 0;
								o_invalid_bit 			<= 1;
						if (i_start)
							begin
								byte_holder				<= i_payloadlength_data;
								latched_no_of_zeros		<= no_of_zeros;
								latched_payload_length	<= i_payloadlength_data;
								state					<= sending_phr;
							end	
					end		
					sending_phr 	:begin
						if (counter <4)
							begin
								counter					<= counter +1;
								o_serial				<= 0;
								o_invalid_bit			<= 0;
								o_recieved_start		<= 1;

							end
						else if (counter < 12)
							begin
								o_serial				<= byte_holder[7];
								byte_holder				<= byte_holder << 1;
								counter					<= counter +1;
								o_recieved_start		<= 0;
							end
						else if (!latched_payload_length)
							begin
								counter					<= 0;
								o_invalid_bit			<= 0;
								o_serial				<= 0;
								state					<= padding;
							end
						else
							begin
								byte_holder				<= {i_payloadlength_data[6:0],1'b0};
								o_serial				<= i_payloadlength_data [7];
								state					<= sending_payload;
								counter					<= 0;
								o_invalid_bit			<= 0;
							end
					end		
					sending_payload 	:begin
						if (o_ram_address < latched_payload_length )
							begin
								if (counter < 6)
									begin
										counter			<= counter +1;
										o_serial		<= byte_holder[7];
										byte_holder		<= byte_holder << 1;
										o_invalid_bit	<= 0;
									end
								else if (counter == 6)
									begin
										o_ram_address	<= o_ram_address +1;
										o_serial		<= byte_holder [7];
										counter			<= counter +1;
										o_invalid_bit	<= 0;
									end
								else
									begin
										byte_holder		<= {i_payloadlength_data[6:0],1'b0};
										o_serial		<= i_payloadlength_data [7];
										counter			<= 0;
										o_invalid_bit	<= 0;
									end
							end
						else
							begin
								counter					<= 0;
								o_invalid_bit			<= 0;
								o_serial				<= 0;
								state					<= padding;
							end
					end
					padding 	:begin
						if (counter < latched_no_of_zeros -1)
							begin
								o_invalid_bit			<= 0;
								counter					<= counter +1;
								o_serial				<= 0;
							end
						else
							begin
								o_done					<= 1;
								o_invalid_bit			<= 1;
								state					<= idle;
							end
					end
				endcase
			end
	end

//===========================combinational Logic=============================//
always @ (*)
	begin	
		intermediate_calc=	i_payloadlength_data[0]+ i_payloadlength_data[2]+ i_payloadlength_data[4]+ i_payloadlength_data[6]-
							i_payloadlength_data[1]- i_payloadlength_data[3]- i_payloadlength_data[5]-i_payloadlength_data[7];
//------------------------------------------------------------------------------------------------------------------------------//
		case (intermediate_calc)
			4'b1101 : no_of_zeros = 6;
			4'b1110 : no_of_zeros = 4;
			4'b1111 : no_of_zeros = 2;
			4'b0000 : no_of_zeros = 6;
			4'b0001 : no_of_zeros = 4;
			4'b0010 : no_of_zeros = 2;
			4'b0011 : no_of_zeros = 6;
			4'b0100 : no_of_zeros = 4;
			default : no_of_zeros = 0;
		endcase
	end
//===========================End Of Module===============================//
endmodule