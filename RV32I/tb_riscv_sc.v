`timescale 1ns/1ns

module tb_riscv_sc;
//cpu testbench

reg clk;
reg start;

SingleCycleCPU riscv_DUT(clk, start);

initial
	forever #5 clk = ~clk;

initial begin
	$dumpfile("output.vcd");
	$dumpvars(0, tb_riscv_sc);

	$monitor("%d, t0 %h, t1 %h, t2 %h, s0 %h, mem %h, r %h",
		$time, 
		riscv_DUT.m_Register.regs[1],
		riscv_DUT.m_Register.regs[2],
		riscv_DUT.m_Register.regs[3],
		riscv_DUT.m_Register.regs[15],	
		riscv_DUT.m_DataMemory.data_memory[3],
		riscv_DUT.instr[11:7]
	);
	clk = 0;
	start = 0;
	#10 start = 1;

	#3000 $finish;

end

endmodule
