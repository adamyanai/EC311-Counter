`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2024 03:21:26 PM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input clk_in,
    input rst,
    output reg divided_clk
);

parameter toggle_value = 49999999; 

reg[32:0] cnt;

always@(posedge clk_in or posedge rst)
begin
    if (rst==1) begin
        cnt <= 0;
        divided_clk <= 0;
    end
    else begin
        if (cnt==toggle_value) begin
            cnt <= 0;
            divided_clk <= ~divided_clk;
        end
        else begin
            cnt <= cnt + 1;
            divided_clk <= divided_clk;
        end
    end
end

endmodule
