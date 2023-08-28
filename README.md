# Computer-Architecture-Project

This is a project which is intended to model a 4-stage pipeline with a custom MIPS ISA. 
- Leveraged Used VHDL to design a four-stage pipeline for SIMD multimedia processing.
- Designed instruction formats and an assembly syntax for operations offering an interface to program the architecture.
- Designed and implemented a custom assembler using Python. This tool converts the devised assembly syntax into machine-
readable code, bridging the gap between high-level programming and low-level hardware operations.


## Components

### System_2
System_2 combines all the other components.
You will input a text file which will contains a set of custom instructions (in Hexadecimal).
Which the output will show the following (every clock cycle):
  - The Program Counter
  - The Instruction (in Hexadecimal) in the Instruction buffer
  - The Output values of the following pipeline registers:
    * IF_ID Register (Instruction Fetch and Decode) 
    * ID_EX Register (Instruction Decode and Execute)
    * EX_WB Register (Execute and Write Back)
  - Input & Output of MultiMedia ALU

