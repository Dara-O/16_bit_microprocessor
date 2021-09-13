`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2021 08:44:51 PM
// Design Name: 
// Module Name: mux4
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


module mux4 #(parameter N=8)(
    input   logic [N-1:0]     d0, d1, d2, d3,
    input   logic [1:0]       sel,
    output  logic [N-1:0]     out
    );
    
    always_comb begin
        case(sel)
            'b00 : out = d0;
            'b01 : out = d1;
            'b10 : out = d2;
            'b11 : out = d3;
            
            default : out = 0;
        endcase
    end

endmodule
