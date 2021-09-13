`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 11:35:28 PM
// Design Name: 
// Module Name: SignExtender
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


module SignExtender(
    input  logic [4:0] in,
    output logic [15:0] out
    );
    
    always_comb begin
        out = {{11{in[4]}}, in};
    end
endmodule
