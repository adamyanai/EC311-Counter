`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 03:40:00 PM
// Design Name: 
// Module Name: counter
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
module counter(
    input [7:0] switch,
    input set_button,
    input clk,
    output [6:0] cathode,
    output [7:0] anode
    );
    
wire s_clock;
wire fsm_clock;
reg [3:0] minutes;
reg [3:0] tens_seconds;
reg [3:0] units_seconds;
wire [3:0] bcd_minutes;
wire [3:0] bcd_tens_seconds;
wire [3:0] bcd_units_seconds;
wire [15:0] display_input;
reg activate = 1;
wire clean;

debouncer debounce(.clk(clk), .noisy(set_button), .clean(clean));
clk_divider slow_clock(.clk_in(clk), .divided_clk(s_clock));
faster_clk_divider fast_clock(.clk_in(clk), .fdivided_clk(fsm_clock));

bin2bcd convert_minutes(.bin(minutes), .bcd(bcd_minutes));
bin2bcd convert_tens_seconds(.bin(tens_seconds), .bcd(bcd_tens_seconds));
bin2bcd convert_units_seconds(.bin(units_seconds), .bcd(bcd_units_seconds));

always @(posedge clean or posedge s_clock) begin
if (clean) begin
    minutes <= (switch/60);
    tens_seconds <= ((switch % 60) / 10);
    units_seconds <= (switch % 10);
    activate = ~activate;
    end
    else if (s_clock && activate) begin
    
        if (units_seconds > 0) begin
            units_seconds <= units_seconds - 1;
        end
        else begin 
            if (tens_seconds > 0) begin
            tens_seconds <= tens_seconds - 1;
            units_seconds <= 9;
            end
            else if (minutes > 0) begin
            minutes <= minutes - 1;
            tens_seconds <= 5;
            units_seconds <= 9;
         end
      end
   end
 end
         
assign display_input = {4'b0000, bcd_minutes, bcd_tens_seconds, bcd_units_seconds};
fsm display(.clock(fsm_clock), .sixteen_bit_number(display_input), .cathode(cathode), .anode(anode));



endmodule