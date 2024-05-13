`timescale 1ns / 1ps

module debouncer(
    input clk,
    input noisy,
    output reg clean
);

reg [15:0] counter = 0;
parameter count_MAX = 30000;

always @(posedge clk) begin
    if (noisy == clean) begin
        counter <= 0;
    end else begin
        if(counter < count_MAX)begin
        counter <= counter + 1;
        end
        if (counter == count_MAX) begin
            clean <= noisy;
            end
            end
            end
            endmodule