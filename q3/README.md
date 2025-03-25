# Complete RV32I CPU

I didn't try the pipelining part.
But I implemented the entire RV32I cpu.


I have divided the opcodes to different types
RTYPE: implemented in the ALU
ITYPE: includes immediate arithmetic and logical functions. Implemented in ALU
I2TYPE: includes load functions. Implemented in partselector m_load module
STYPE: includes store functions. Implemented in partselector m_store module
BTYPE: includes branch functions. Implemented in ALU's zero output. Branching happens only when zero and branch(in CU) are both 1.
JAL and AUIPC: implemented in the writeback mux (200th line in SingleCycleCPU.v)
JALR: implemented in the pcnext mux (150th line SingleCycleCPU.v)
LUI: implemented in a mux and control unit (98th line in SingleCycleCPU.v)

parameters.v is not made according to this folder. But you are encouraged to run  the RV32I folder to get the same result.

I have made a custom testbench with extra assembly codes for you to test their functionality. 