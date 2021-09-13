`timescale 1ns / 1ps

module NBitAdder  #(parameter N=8) (
    input   logic [N-1:0] opA, opB,
    input   logic         cin,
    output  logic [N-1:0] out,
    output  logic         cout    
    );
    
   always_comb begin
    {cout, out} = opA+opB + cin;
   end
endmodule
