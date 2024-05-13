// fsm.v
module fsm(
    input clock,
    input [15:0] sixteen_bit_number, // Changed to 16 bits to accommodate up to 9999
    output [6:0] cathode,
    output reg [7:0] anode
);
    
reg [3:0] four_bit_number;
reg [1:0] state; // stores state of FSM

// Instantiate the decoder module
decoder decode(
    .number(four_bit_number),
    .cathode(cathode)
);

initial begin
    state = 0;
    anode = 8'b11111111;
end

always @(posedge clock) begin
    state = state + 1; // increment state
    
    // Set anode and select the corresponding 4 bits from the 16-bit number
    case(state)
        2'b00: begin
            anode = 8'b11111110; // Activate the first display
            four_bit_number = sixteen_bit_number[3:0]; // Lower 4 bits
        end
        2'b01: begin
            anode = 8'b11111101; // Activate the second display
            four_bit_number = sixteen_bit_number[7:4]; // Next 4 bits
        end
        2'b10: begin
            anode = 8'b11111011; // Activate the third display
            four_bit_number = sixteen_bit_number[11:8]; // Next 4 bits
        end
        2'b11: begin
            anode = 8'b11110111; // Activate the fourth display
            four_bit_number = sixteen_bit_number[15:12]; // Top 4 bits
        end
    endcase
end

endmodule