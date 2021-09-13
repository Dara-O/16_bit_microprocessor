`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2021 11:39:32 PM
// Design Name: 
// Module Name: Memory
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


module Memory(
    input   logic [9:0] addr,
    input   logic        clk,
    input   logic        reset, 
    input   logic        writeEn,
    input   logic [15:0] dataWrite, 
    output  logic [15:0] dataRead
    );
    
    logic [15:0] mem [2**10] = '{default: 'b0 };
    
    // loading test instructions 
    initial begin 
        mem[0] = 16'b01000_0000_0001_100; // lw $s1, 16($s0)
        mem[1] = 16'b01001_0000_0010_100; // lw $s2, 17($s0
        mem[2] = 16'b0_0010_0001_0011_001;// add $s3, s1, s2
        mem[3] = 16'b01010_0000_0011_101; // sw $s3, 18($s0) 
        mem[4] = 16'b0_0000_0000_0000_000; // halt
        mem[8]= 16'b0_0000_0000_0000_001;
        mem[9]= 16'b0_0000_0000_0000_011;
    end
    
    always_comb begin
        dataRead = mem[addr];
    end
    
    always_ff @ (posedge clk, posedge reset) begin
        if(reset) mem <= '{default: 'b0};
        else if(writeEn) mem[addr] <= dataWrite;
    end
endmodule
