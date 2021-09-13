# 16-Bit Microprocessor
A 16 bit multicycle microprocessor modeled using SystemVerilog and developed using Xilinx Vivado. 
<br>
![](https://raw.githubusercontent.com/Dara-O/16_bit_microprocessor/main/images/first_successful_test.png)
<div align="center">Waveform of the first successful test; calculating 3 + 1</div>
<div align="center">load 1 => load 3 => add => store result</div>


## Sytem Details:
- operand size: 16 bits
- memroy address bus width: 10 bits
- register address bus width: 4 bits
- Maximum number of cycles per instruction: 5
- Minimum number of cycles per instruction: 3
### Supported Instructions
- add
- sub
- mult
- lw (load word)
- sw (store word)
- slt (set less than)
- j (jump/unconditional bracnch)
- beq (branch if equal)
- halt

## Instruction Encoding
- **add, sub, mult, slt, halt**

| immediate | rt    | rs   | rd  | op code |
|:---------:|-------|------|-----|:-------:|
|     15    | 14:11 | 10:7 | 6:3 |   2:0   |

- **lw, sw**<br>

| immediate | rd (destination/source) | base address ptr | op code |
|:---------:|:-----------------------:|:----------------:|:-------:|
|   15:11   |           10:7          |        6:3       |   2:0   |

- **j, beq** 

| immediate | not used | not used | op code |
|:---------:|:--------:|:--------:|:-------:|
|   15:11   |   10:7   |    6:4   |   3:0   |

## Op Codes

|        Instruction       | OpCode |
|:------------------------:|:------:|
|           halt           |   000  |
|            add           |   001  |
|            sub           |   010  |
|           mult           |   011  |
|            lw            |   100  |
|            sw            |   101  |
|            slt           |   110  |
| j (unconditional branch) | 111(0) |
| Beq (conditional branch) | 111(1) |

## ALU Op Codes

| Instruction | ALUOp |
|:-----------:|:-----:|
|     add     |   00  |
|     sub     |   01  |
|     mult    |   10  |
|     slt     |   11  |


## Datapath (Diagram)
![Synthesized Data Path](https://raw.githubusercontent.com/Dara-O/16_bit_microprocessor/main/images/multi-cycle%20datapath.drawio.png)


## Datapath (Synthesized)
![Synthesized Data Path](https://raw.githubusercontent.com/Dara-O/16_bit_microprocessor/main/images/synthesiszed_datapath_no_memory.PNG)

## Controller State Transition Diagram
![](https://raw.githubusercontent.com/Dara-O/16_bit_microprocessor/main/images/16_bit_microprocessor_FSM.drawio.png)

**All Diagrams were created using draw.io**

## Resouces:
- Digital Design and Computer Architecture,  David Harris (Author), Sarah Harris (Author), Morgan Kaufmann Publishers
- RTL Modeling with SystemVerilog for Simulation and Synthesis: Using SystemVerilog for ASIC and FPGA Design, Stuart Sutherland (Author), CreateSpace Independent Publishing 
- [Digital Design and Computer Architecture: Onur Mutlu - ETH Zuric](https://www.youtube.com/playlist?list=PL5Q2soXY2Zi_FRrloMa2fUYWPGiZUBQo2)
