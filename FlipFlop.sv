`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 01:36:47 PM
// Design Name: 
// Module Name: FlipFlop
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


module FlipFlop #(parameter N=8)(
    input  logic [N-1:0] d,
    input  logic         clk,
    input  logic         clkEn,
    input  logic         reset,
    output logic [N-1:0] q
    );
    
    
    always_ff @ (posedge clk, posedge reset) begin
        if(reset) q <= 'b0;
        else if(clkEn) q <= d;
    end
    
endmodule
