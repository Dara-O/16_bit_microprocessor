`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 04:07:07 PM
// Design Name: 
// Module Name: NBitMultiplier
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


module NBitMultiplier #(parameter N=8)(
    input   logic [N-1:0] opA, opB,
    output  logic [N-1:0] out
    );
    
    always_comb begin
        out = opA * opB;
    end 
    
endmodule
