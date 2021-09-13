`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 10:23:46 PM
// Design Name: 
// Module Name: NBitRegister
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


module RegisterFile(
    input  logic [3:0]     addrA,
    input  logic [3:0]     addrB,
    input  logic [3:0]     writeAddr,
    input  logic           writeEn,
    input  logic [15:0]    dataWrite,
    input  logic           clk,
    input  logic           reset, 
    output logic [15:0]    dataA,
    output logic [15:0]    dataB
    );
    
    
    
    logic [15:0] mem [16] = '{default:'b0};
        
    always_comb begin
        dataA = mem[addrA];
        dataB = mem[addrB];
    end
    
    always_ff @(posedge clk, posedge reset) begin
        if(reset) mem <= '{default:'b0};
        else if(writeEn) mem[writeAddr] <= dataWrite;
        
    end
    
   
endmodule
