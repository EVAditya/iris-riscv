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

	$monitor("%d, t0 %d, t1 %d, t2 %d, s0 %d, mem %d",
		$time, riscv_DUT.m_Register.regs[5],
		riscv_DUT.m_Register.regs[6],
		riscv_DUT.m_Register.regs[7],
		riscv_DUT.m_Register.regs[8],
		riscv_DUT.m_DataMemory.data_memory[]
	);
	clk = 0;
	start = 0;
	#10 start = 1;

	#3000 $finish;

end

endmodule
