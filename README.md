# Computer-Architecture-Project

This is a project which is intended to model a 4-stage pipeline with a custom MIPS ISA

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
