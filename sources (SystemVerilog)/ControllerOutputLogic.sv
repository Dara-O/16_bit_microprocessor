`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 09:40:40 PM
// Design Name: 
// Module Name: ControllerOutputLogic
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



module ControllerOutputLogic
import FSMStateData::*;
    (
        input  state_t          current_state,
        input  logic    [2:0]   op_code,
        input  logic            ltReg,
        
        output logic            halt_clk,
        output logic    [1:0]   alu_op,
        output logic            alu_src_a_mux_sel,
        output logic    [1:0]   alu_src_b_mux_sel,
        output logic            load_instr,
        output logic            hold_decode,
        output logic            instr_or_data_mux_sel,
        output logic            mem_write_en,
        output logic            reg_write_en,
        output logic            reg_write_mux_sel
    );
    
    always_comb begin
        case (current_state)
        
            S0 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b11;
                load_instr = 1;
                hold_decode = 0;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S1 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b11;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S2 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 1;
                alu_src_b_mux_sel = 'b10;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S3 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b11;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 1;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S4 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b11;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 1;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S5 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b11;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 1;
                mem_write_en = 1;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S6 : begin 
                case (op_code)
                    3'b001 : alu_op = 2'b00;
                    3'b010 : alu_op = 2'b01;
                    3'b011 : alu_op = 2'b10;
                    
                    default: begin
                        alu_op = 2'b00;
                        $display("Unrecognized op_code in Output Logic.");
                    end
                endcase
                
                alu_src_a_mux_sel = 1;
                alu_src_b_mux_sel = 'b01;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S7 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 1;
                alu_src_b_mux_sel = 'b11;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 1;
                reg_write_mux_sel = 1;
                halt_clk = 0;
            end
            
            S8 : begin 
                alu_op = 2'b11;
                alu_src_a_mux_sel = 1;
                alu_src_b_mux_sel = 'b01;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S9 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b10;
                load_instr = 1;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S10 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b10;
                load_instr = ltReg;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 0;
            end
            
            S11 : begin 
                alu_op = 2'b00;
                alu_src_a_mux_sel = 0;
                alu_src_b_mux_sel = 'b11;
                load_instr = 0;
                hold_decode = 1;
                instr_or_data_mux_sel = 0;
                mem_write_en = 0;
                reg_write_en= 0;
                reg_write_mux_sel = 0;
                halt_clk = 1;
            end
            
            default : $display("Unrecognized State in Output Logic: %b", current_state);
            
        endcase
    end
        
endmodule
