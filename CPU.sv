`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 02:06:30 PM
// Design Name: 
// Module Name: CPU
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


module CPU(
        input  logic        clk, 
        input  logic        reset,
        input  logic [15:0] mem_data_read,
        
        output logic [9:0]  mem_addr,
        output logic [15:0] mem_data_write,
        output logic        mem_write_en, 
        output logic        halt_clk
    );
    
    logic [9:0]  pc_out;
    logic [15:0] fetch_decode_ff_out;
    logic [3:0]  reg_dest_addr, reg_src_addr_b, reg_src_addr_a;
    logic [4:0]  not_xtend_offset_immediate;
    logic [15:0] xtend_offset_immediate;
    logic [2:0]  op_code;
    logic        beqEn, ltReg, load_instr, hold_decode;
    logic        reg_write_en;
    logic        instr_or_data_mux_sel;
    logic [15:0] reg_data_a, reg_data_b; 
    logic [15:0] decode_execute_ff_a_out, decode_execute_ff_b_out;
    logic [15:0] alu_src_a, alu_src_b;
    logic [15:0] alu_out, execute_memory_ff_out;
    logic [15:0] reg_write_mux_out, memory_data_ff_out;
    logic [1:0]  alu_op;
    logic        alu_src_a_mux_sel;
    logic [1:0]  alu_src_b_mux_sel;
    logic        reg_write_mux_sel;
    
    assign mem_data_write = reg_data_b; 
    
    ControlUnit controller(
        .clk(clk), 
        .reset(reset),
        .op_code(op_code),
        .beqEn(beqEn),
        .ltReg(ltReg),
        
        .halt_clk(halt_clk),
        .load_instr(load_instr),
        .hold_decode(hold_decode),
        .reg_write_en(reg_write_en),
        .alu_op(alu_op),
        .alu_src_a_mux_sel(alu_src_a_mux_sel),
        .alu_src_b_mux_sel(alu_src_b_mux_sel),
        .instr_or_data_mux_sel(instr_or_data_mux_sel),
        .mem_write_en(mem_write_en),
        .reg_write_mux_sel(reg_write_mux_sel)
    );
    
   
    FlipFlop #(10) pc(
                .d(alu_out[9:0]), 
                .clk(clk), 
                .clkEn(load_instr), 
                .reset(reset), 
                
                .q(pc_out)
    );

    mux2 #(10) instr_or_data_mux(
                .d0(pc_out),
                .d1(execute_memory_ff_out[9:0]),
                .sel(instr_or_data_mux_sel),
                .out(mem_addr)
    
    );
    
    FlipFlop #(16) fetch_deconde_ff(
                .d(mem_data_read),
                .clk(clk),
                .clkEn(~hold_decode), 
                .reset(reset),
                                    
                .q(fetch_decode_ff_out) 
    ); 
    
    FlipFlop #(16) memory_data_ff(
                .d(mem_data_read),
                .clk(clk),
                .clkEn(1),
                .reset(reset),
                
                .q(memory_data_ff_out)
    );
    
    DecodeUnit decode_unit(
                           .instruction(fetch_decode_ff_out),
                           
                           .op_code(op_code),// to the control unit
                           .beqEn(beqEn), // to the control unit
                           .dest_addr(reg_dest_addr), 
                           .src_addr_a(reg_src_addr_a), 
                           .src_addr_b(reg_src_addr_b),
                           .immediate(not_xtend_offset_immediate) // to the sign extendder
    );
    
    mux2 #(16) reg_write_mux(
        .d0(memory_data_ff_out),
        .d1(execute_memory_ff_out),
        .sel(reg_write_mux_sel),
        
        .out(reg_write_mux_out)
    );
    
    RegisterFile regfile(
                     .addrA(reg_src_addr_a),
                     .addrB(reg_src_addr_b),
                     .writeAddr(reg_dest_addr),
                     .writeEn(reg_write_en),
                     .dataWrite(reg_write_mux_out), 
                     .clk(clk),
                     .reset(reset),
                     
                     .dataA(reg_data_a),
                     .dataB(reg_data_b) 
    );
    
    
    
    FlipFlop #(16) decode_execute_ff_a(
                    .d(reg_data_a),
                    .clk(clk),
                    .clkEn(1),
                    .reset(reset),
                    
                    .q(decode_execute_ff_a_out)                
    );
    
    FlipFlop #(16) decode_execute_ff_b(
                    .d(reg_data_b),
                    .clk(clk),
                    .clkEn(1),
                    .reset(reset),
                    
                    .q(decode_execute_ff_b_out)                
    );
    
    SignExtender sign_extender(
                    .in(not_xtend_offset_immediate),
                    .out(xtend_offset_immediate)
    );
    
    mux2 #(16) alu_src_a_mux(
                    .d0({6'b0, pc_out}),
                    .d1(decode_execute_ff_a_out),
                    .sel(alu_src_a_mux_sel), 
                    
                    .out(alu_src_a)
    );
        
    mux4 #(16) alu_src_b_mux(
                    .d0('b0), // not used
                    .d1(decode_execute_ff_b_out), 
                    .d2(xtend_offset_immediate),
                    .d3('b01),
                    .sel(alu_src_b_mux_sel), 
                    
                    .out(alu_src_b) 
    );
    
    ALU alu(
            .ALUOp(alu_op), 
            .SrcA(alu_src_a),
            .SrcB(alu_src_b),
            .ltRegReset(reset),
            
            .ltReg(ltReg),
            .aluOut(alu_out) 
    );
    
    FlipFlop #(16) execute_memory_ff(
            .d(alu_out),
            .clk(clk),
            .clkEn(1),
            .reset(reset),
            
            .q(execute_memory_ff_out)
    );
    
    
endmodule
