`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 03:54:12 PM
// Design Name: 
// Module Name: faster_clk_divider
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


module faster_clk_divider(
    input clk_in,
    input rst,
    output reg fdivided_clk
);

parameter toggle_value = 4999; 

reg[32:0] cnt;

always@(posedge clk_in or posedge rst)
begin
    if (rst==1) begin
        cnt <= 0;
        fdivided_clk <= 0;
    end
    else begin
        if (cnt==toggle_value) begin
            cnt <= 0;
           fdivided_clk <= ~fdivided_clk;
        end
        else begin
            cnt <= cnt + 1;
            fdivided_clk <= fdivided_clk;
        end
    end
end

endmodule
