// `timescale 1ns/1ns

// module tb_riscv_sc;
// //cpu testbench

// reg clk;
// reg start;

// SingleCycleCPU riscv_DUT(clk, start);

// initial
// 	forever #5 clk = ~clk;

// initial begin
// 	$dumpfile("output.vcd");
// 	$dumpvars(0, tb_riscv_sc);

// 	$monitor("%d, x2 %h, x3 %h, x5 %h, x7 %h, mem %h, r %h, %h",
// 		$time, 
// 		riscv_DUT.m_Register.regs[2],
// 		riscv_DUT.m_Register.regs[3],
// 		riscv_DUT.m_Register.regs[5],
// 		riscv_DUT.m_Register.regs[7],	
// 		riscv_DUT.m_DataMemory.data_memory[3],
// 		riscv_DUT.instr[11:7],
// 		riscv_DUT.m_PC.pc_o
// 	);
// 	clk = 0;
// 	start = 0;
// 	#10 start = 1;

// 	#3000 $finish;

// end

// endmodule

module tb_riscv_sc;
//cpu testbench

reg clk;
reg start;

SingleCycleCPU riscv_DUT(clk, start);

initial
	forever #5 clk = ~clk;

initial begin
	clk = 0;
	start = 0;
	#10 start = 1;

	#3000 $finish;

end

endmodule