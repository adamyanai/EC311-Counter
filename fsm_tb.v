`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 04:08:06 PM
// Design Name: 
// Module Name: fsm_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm_test(

    );
    
    reg clock;
    reg [15:0] a;
    wire [6:0] cathode;
    wire [7:0] anode;
    
    fsm DUT (
        .clock(clock),
        .sixteen_bit_number(a),
        .cathode(cathode),
        .anode(anode)
    ); 
    
    // Clock generator
    always #1 clock = ~clock;
    always #8 a = a + 8;
    
    initial begin
        clock = 0;
        a = 0;
    end
    initial #100 $finish;
    
endmodule
