module tb_fp_addition();
	
	reg clk;
        reg start;
	reg [31:0] fp_input;

	wire [31:0] fp_sum;
	wire done;
	wire overflow;
	wire underflow;

	// design module instantiation
	fp_addition dut(.clk(clk), .start(start), .fp_input(fp_input), .fp_sum(fp_sum), .done(done), .overflow(overflow), .underflow(underflow));
	
	// clock generation
	always #5 clk = ~clk;
        
	// task to print values in modified hex format
	task print_hex;
		input [31:0] val;
		begin
			$write("x%0H%0H%0H%0H_%0H%0H%0H%0H", val[31:28], val[27:24], val[23:20], val[19:16], val[15:12], val[11:8], val[7:4], val[3:0]);
		end
	endtask
	
	// task to apply 2 inputs
	/* The FSM needs:
	   Cycle 1 (start=1): IDLE captures fp_input=a, moves to LOAD_B
	   Cycle 2 (start=1): LOAD_B captures fp_input=b, moves to ALIGN
	   After that: start can go low
	*/	
	task apply_test;
		input [31:0] a;
		input [31:0] b;
		begin
			// Cycle 1: present A with start=1 -> FSM in IDLE A
			@(negedge clk)
			start = 1;
			fp_input = a;
			
			// Cycle 2: present B while start high -> FSM in LOAD_B
			@(negedge clk)
			fp_input = b;
			
			// Now deassert start - FSM is in ALIGN or beyond
			@(negedge clk)
			start = 0;
			
			// Wait for FSM to finish
			wait(done == 1'b1);
			@(negedge clk); 	// let output settle

			// Write output to console
			$write("A = "); print_hex(a);
			$write(" | B = "); print_hex(b);
			$write(" | SUM = "); print_hex(fp_sum);
			$display(" | OVERFLOW = %b | UNDERFLOW = %b", overflow, underflow);
			
			#20;
		end
	endtask


	// Test cases
	initial
	begin
		clk = 0;
		start = 0;
		fp_input = 0;

		#12;

		// 0 + 0 
		apply_test(32'h0000_0000, 32'h0000_0000);
			
		// 1.0 + 1.0 = 2.0
		apply_test(32'h3F80_0000, 32'h3F80_0000);

		// -1.0 + -1.0 = -2.0 
		apply_test(32'hBF80_0000, 32'hBF80_0000);
		
		// 1 + -1 = 0
		apply_test(32'h3F80_0000, 32'hBF80_0000);
		
		// max_float + 1
		apply_test(32'h7F7F_FFFF, 32'h3F80_0000);
		
		// -max + -1 
		apply_test(32'hFF7F_FFFF, 32'hBF00_0000);
		
		// max + max -> overflow 
		apply_test(32'h7F7F_FFFF, 32'h7F7F_FFFF);
		
		// -max + -max -> overflow 
		apply_test(32'hFF7F_FFFF, 32'hFF7F_FFFF);
		
		// 1.11x2^8 + -1.11x2^6
		apply_test(32'h43E0_0000, 32'hC2E0_0000);
		
		// -1.11x2^8 + 1.11x2^6
		apply_test(32'hC3E0_0000, 32'h42E0_0000);	
		
		// 1.11x2^127 + 1.11x2^6
		apply_test(32'h7F7F_FFFF, 32'h7380_0000);	

		// -1.11x2^127 + -0.11x2^127
		apply_test(32'hFF7F_FFFF, 32'hF380_0000);
		
		// 1.11x2^127 + 0.11x2^127
		apply_test(32'h7F7F_FFFE, 32'h7380_0000);
		
		// -1.11x2^127 + -0.11x2^127
		apply_test(32'hFF7F_FFFE, 32'hF380_0000);
		
		// 1.1x2^-126 + -1.0x2^-126
		apply_test(32'h00C0_0000, 32'h8080_0000);

		#100;
	       	$finish();
	end

	// Generate vcd file to see waveform
	initial
	begin
		$dumpfile("dump.vcd");
		$dumpvars(0);
	end
endmodule

