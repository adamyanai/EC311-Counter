`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 04:02:12 PM
// Design Name: 
// Module Name: counter_tb
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


`timescale 1ns / 1ps

module counter_tb;

    // Inputs
    reg clock;
    reg rst;
    reg set_button;
    reg [7:0] initial_value;

    // Outputs
    wire [6:0] cathode;
    wire [7:0] anode;

    // Instantiate the Unit Under Test (UUT)
    counter uut(
        .clock(clock),
        .rst(rst),
        .set_button(set_button),
        .initial_value(initial_value),
        .cathode(cathode),
        .anode(anode)
    );

    // Clock generation
    always #5 clock = ~clock; // Generate a 100 MHz clock (period = 10ns)

    // Initial block for test stimulus
    initial begin
        // Initialize Inputs
        clock = 0;
        rst = 0;
        set_button = 0;
        initial_value = 8'd59; // 59 seconds

        // Wait for global reset
        #100;
        
        // Test reset functionality
        rst = 1; #10; rst = 0; #10;

        // First press of set button loads the time but does not start the countdown
        set_button = 1; #10; set_button = 0; #10;

        // Wait 100 ns for global reset to finish
        #100;

        // Second press of set button starts the countdown
        set_button = 1; #10; set_button = 0;

        // Wait to observe the countdown
        #2000; // Wait long enough to see the countdown

        // Apply Reset to test reset functionality
        rst = 1; #10; rst = 0;

        // Finish simulation
        $finish;
    end

endmodule