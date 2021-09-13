`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 10:17:53 PM
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
        input  logic        clk,
        input  logic        reset, 
        input  logic [2:0]  op_code,
        input  logic        beqEn,
        input  logic        ltReg,
        
        output logic        halt_clk,
        output logic [1:0]  alu_op,
        output logic        alu_src_a_mux_sel,
        output logic [1:0]  alu_src_b_mux_sel,
        output logic        load_instr,
        output logic        hold_decode,
        output logic        instr_or_data_mux_sel,
        output logic        mem_write_en,
        output logic        reg_write_en,
        output logic        reg_write_mux_sel
    );
    
    import FSMStateData::*; 
    
    state_t current_state=S0, next_state;
    
    ControllerNextStateLogic next_state_logic(
        .current_state(current_state),
        .op_code(op_code),
        .beqEn(beqEn),
        
        .next_state(next_state) 
        
    );
    
    
    always_ff @ (posedge clk, posedge reset) begin
        if(reset) current_state <= S0;
        else      current_state <= next_state;
        $display("Current State: %b", current_state);
    end
    
    ControllerOutputLogic output_logic(
        .current_state(current_state),
        .op_code(op_code),
        .ltReg(ltReg),
        
        .halt_clk(halt_clk),
        .alu_op(alu_op),
        .alu_src_a_mux_sel(alu_src_a_mux_sel),
        .alu_src_b_mux_sel(alu_src_b_mux_sel),
        .load_instr(load_instr), 
        .hold_decode(hold_decode),
        .instr_or_data_mux_sel(instr_or_data_mux_sel),
        .mem_write_en(mem_write_en),
        .reg_write_en(reg_write_en),
        .reg_write_mux_sel(reg_write_mux_sel)
    );
    
   
    
endmodule
