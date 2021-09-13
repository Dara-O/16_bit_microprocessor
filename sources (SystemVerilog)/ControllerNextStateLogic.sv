`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 08:35:43 PM
// Design Name: 
// Module Name: ControllerNextStateLogic
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



module ControllerNextStateLogic
    import FSMStateData::*;
    (
        input  state_t         current_state,
        input  logic   [2:0]   op_code,
        input  logic           beqEn,
        
        output state_t  next_state
    );
    
    always_comb begin
        
        case(current_state)
            
            // FETCH
            S0                  : next_state = S1;
            
            // DECODE
            S1                  : begin: DECODE
            
                case({op_code, beqEn}) inside
                    
                    // LW, SW
                    'b10?_?                     : next_state = S2;
                    
                    // ADD, SUB, MULT
                    'b001_?, 'b01?_?            : next_state = S6;
                    
                    // SLT
                    'b110_?                     : next_state = S8;
                    
                    // JUMP (J)
                    'b111_0                     : next_state = S9;
                    
                    // BEQ
                    'b111_1                     : next_state = S10;
                    
                    // HALT
                    'b000_?                     : next_state = S11;
                    
                    default                     : begin 
                                                next_state = S11; 
                                                $display("Unrecognized Instruction in Next State Logic");
                                             
                                                end                    
                endcase
            
            end : DECODE
            
            // EXECUTE SW/LW
            S2                          : begin: EXECUTE_SW_LW
                                        if(op_code === 'b100) next_state = S3;
                                        else                  next_state = S5;
            end : EXECUTE_SW_LW
            
            // MEMORY LW
            S3                          : next_state = S4;
            
            // MEMORY/WRITEBACK
            S4, S5, S7, S8, S9, S10     : next_state = S0;
            
            // EXECUTE ADD, SUB, MULT
            S6                          : next_state = S7;
            
            S11                         : next_state = S11;
             
            default                     : begin 
                                            next_state = S11;
                                            $display("Unrecognized State in Next State Logic. %b", current_state);
                                         end        
        endcase
        
    end
    
endmodule
