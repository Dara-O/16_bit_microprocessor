`timescale 1ns / 1ps

module ALU(
    input  logic [1:0]   ALUOp,
    input  logic [15:0]  SrcA,
    input  logic [15:0]  SrcB,
    input  logic         ltRegReset, 
    output logic         ltReg,
    output logic [15:0]  aluOut
    );
    
    logic [15:0] a, b;
    logic        cin;
    logic [15:0] addRes, multRes;
        
    // instanciate the adder and multiplier
    NBitAdder #(16) adder(.opA(a), .opB(b), .cin(cin), .out(addRes));
    NBitMultiplier #(16) multiplier(.opA(a), .opB(b), .out(multRes));
    
    // Selecting the inputs
    always_comb begin
        case(ALUOp)
        
        2'b00, 2'b10 : begin
            a = SrcA;
            b = SrcB;
            cin = 0;
        end
        
        // Subtraction 
        2'b01, 2'b11 : begin
            a = SrcA;
            b = ~SrcB;
            cin = 1;
        end
        
        endcase
    end
        
    // decide the output
    always_comb begin
        case(ALUOp)
            2'b00, 2'b01, 2'b11 : aluOut = addRes;
            2'b10 : aluOut = multRes;
        endcase
    end 
    
    // Control the eqRegister
    always_latch begin
        if(ALUOp == 2'b11) ltReg <= addRes[15];
        else if(ltRegReset) ltReg <= 1'b0;
    end
    
    
endmodule
