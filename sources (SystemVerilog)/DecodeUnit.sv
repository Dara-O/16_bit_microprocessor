`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 04:00:41 PM
// Design Name: 
// Module Name: DecodeUnit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Splits up the instruction bus into its bit fields as determined by the ISA.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DecodeUnit(
        input  logic [15:0] instruction,
        
        output logic [2:0]  op_code,
        output logic        beqEn,
        output logic [3:0]  dest_addr, src_addr_a, src_addr_b,
        output logic [4:0]  immediate
    );
    
    always_comb begin
        op_code         = instruction[2:0];
        beqEn           = instruction[3];
        dest_addr       = instruction[6:3];
        src_addr_a      = instruction[10:7];
        immediate       = instruction[15:11];
        
        if(op_code === 'b101) begin
            src_addr_b = instruction[6:3];
        end
        else begin
            src_addr_b = instruction[14:11];
        end
        
    end
    
endmodule
