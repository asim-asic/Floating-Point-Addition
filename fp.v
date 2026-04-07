module fp_addition(
	input clk,	// clock
	input start,	// start signal to begin operation
	input [31:0] fp_input, // 32-bit floating point input 
	
	output reg [31:0], fp_sum,	// final floating point result
	output reg done,	// operation complete flag
	output reg overflow,	// exponent overflow flag
	output reg underflow	// exponent underflow flag
);


	//------------- Internal signals --------------------
	reg [25:0] frac_a;	// fraction of component A
				/* 23 bit fraction + 1 hidden bit + extra bits for alignment*/ 
	reg [25:0] frac_b;	// fraction of component B

	reg [7:0] exp_a;	// exponent of component A
	reg [7:0] exp_b;	// exponent of component B

	reg sign_a;		// sign of component A
	reg sign_b;		// sign of component B
	

	// ------------------ WIRES ----------------------
	wire frac_overflow;	// fraction overflow (after addition)
	wire frac_underflow;	// fraction underflow or normalization required

	wire [27:0] fraction_a_comp;	// used for substraction when sign is negative (2's complement) 
	wire [27:0] fraction_b_comp;

	wire [27:0] add_out;	// output of fraction adder

	wire [27:0] frac_sum;	// final fraction after normalization
	
	// -------------------- Control ----------------------------
	reg [2:0] state;	// FSM state register
	



	// Initial block
	initial
	begin
		state = 0;
		done = 0;
		overflow = 0;
		underflow = 0;
		frac_a = 0;
		frac_b = 0;
		exp_a = 0;
		exp_b = 0;
		sign = 0;
		sign = 0;
	end
	

	// 2's complement
	assign frac_a_comp = (sign_a == 1'b1) ? ~({2'b00, frac_a}) + 1 : {2'b00, frac_a}; 
	assign frac_b_comp = (sign_b == 1'b1) ? ~({2'b00, frac_b}) + 1 : {2'b00, frac_b};
	
	// Add fraction
	assign add_out = (frac_a_comp + frac_a_comp);	
	
	// Convert back to magnitude if result negative
	assign frac_sum = ((add_out[27] == 1'b0) ? add_out : ~add_out + 1;
	
	// overflow (need right shift)
	assign frac_overflow = frac_sum[27] ^ frac_sum[26];
	
	// underflow (need left shift)
	assign frac_underflow = ~frac_a[25];

	// pack final result
	assign fp_sum = {sign_a, exp_a, frac_a[24:2]};


	// -------------------------------------- FSM -----------------------
	always @(posedge clk)
	begin	
		case(start)
			0: begin
				if(start == 1'b1)
				begin
					exp_a <= fp_input[30:23];
					sign_a <= fp_input[31];
					frac_a[24:0] <= {fp_input[22:0], 2'b00};
					if(fp_input == 0)
					begin
						frac_b[25] <= 1'b0;
					end	
					else
					begin
						frac_b[25] <= 1'b1;
					end
					done <= 1'b0;
					overflow <= 1'b0;
					underflow <= 1'b0;
					state <= 1;
				end
			   end	   
			1: begin
				exp_b <= fp_input[30:23];
				sign_b <= fp_input[31];
				frac_b[24:0] <= {fp_input[22:0], 2'b00};
				if(fp_input == 0)
				begin
					frac_b[25] <= 1'b0;
				end	
				else
				begin
					frac_b[25] <= 1'b1;
				end
				state <= 2;
				end
			   end
			2: begin
				if(frac_a == 0 | frac_b == 0)
				begin
					state <= 3;
				end
				else
				begin
					if(exp_a == exp_b)
					begin
						state <= 3;
					end
					else if(exp_a < exp_b)
					begin
						frac_a <= {1'b0, frac_a[25:1]};
						exp_a <= exp_a + 1;
					end
					else
					begin
						frac_b <= {1'b0, frac_2[25:1]};
						exp_b <= exp_b + 1;
					end
				end
			   end
		        3: begin
				sign_a <= add_out[27];
				if(frac_overflow == 1'b0)
				begin
					frac_a <= frac_sum[25:0];
				end
				else
				begin
					frac_a <= frac_sum[26:1];
					exp_a <= exp_a + 1;
				end
				state <= 4;
			   end
			4: begin
			   	if(frac_a == 0)
				begin
					exp_a <= 8'b0000_0000;
					state <= 6;
				end
				else
				begin
					state <= 5;
				end
			   end
			5: begin
				if(exp_a == 0)
				begin
					underflow <= 1'b1;
					state <= 6;
				end
				else if (frac_overflow == 1'b0)
				begin
					state <= 6;
				end
				else
				begin
					frac_a <= {frac[24:0], 1'b0};
					exp_a <= exp_a - 1;
				end
			   end
			6: begin
			 	if(exp_a == 255)
				begin
					overflow <= 1'b1;
				end
				done <= 1'b1;
				state <= 0;	
			   end
		endcase
	end
endmodule
