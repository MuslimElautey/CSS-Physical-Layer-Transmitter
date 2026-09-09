module qpsk_mapper (
    input               I_bit,
    input               Q_bit,
    output reg signed [1:0] X_real,
    output reg signed [1:0] X_imag
);

    always @(*) begin
        case ({I_bit,Q_bit})
            // I = 0 , Q = 0 --> maps to I = -1 , Q = -1 in Matlab
            // The equation is: Xn = ((I + Q) - j*(I - Q))/2
            2'b11 : begin X_real = 2'b01 ; X_imag = 2'b00; end    //  1
            2'b01 : begin X_real = 2'b00 ; X_imag = 2'b01; end    //  j
            2'b00 : begin X_real = 2'b11 ; X_imag = 2'b00; end    // -1
            2'b10 : begin X_real = 2'b00 ; X_imag = 2'b11; end    // -j
            default: begin X_real = 2'b00; X_imag = 2'b00; end
        endcase
    end

endmodule
