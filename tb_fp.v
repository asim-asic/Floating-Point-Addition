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

	// task to apply 2 inputs
	task apply_test;
		input [31:0] a;
		input [31:0] b;
		begin
			@(posedge clk)
			start = 1;
			fp_input = a;

			@(posedge clk)
			fp_input = b;

			@(posedge clk)
			start = 0;

			wait(done);
			$display("A = %h | B = %h | SUM = %h | OVF = %b | UNF = %b", a, b, fp_sum, overflow, underflow);
			
			#10;
		end
	endtask


	// Test cases
	initial
	begin
		clk = 0;
		start = 0;

		#10
		// 0 + 0 
		apply_test(32'h0000_0000, 32'h0000_0000);
		 
		// 1 + 1
		apply_test(32'h3F80_0000, 32'h3F80_0000);

		// -1 + -1 
		apply_test(32'hBF80_0000, 32'hBF80_0000);
		
		// 1 + -1
		apply_test(32'h3F80_0000, 32'hBF80_0000);
		
		// max + 1
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
		apply_test(32'hCE30_0000, 32'h42E0_0000);	
		
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

		#10 $finish();
	end
endmodule

