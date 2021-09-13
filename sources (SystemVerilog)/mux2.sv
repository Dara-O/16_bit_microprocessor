`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2021 08:38:02 PM
// Design Name: 
// Module Name: mux2
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


module mux2 #(parameter N=8)(
    input   logic [N-1:0]     d0, d1,
    input   logic             sel,
    output  logic [N-1:0]     out
    );
    
    always_comb begin
        out = sel ? d1 : d0;
    end
endmodule
