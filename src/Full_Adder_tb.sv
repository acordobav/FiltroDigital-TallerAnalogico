module Full_Adder_tb();

logic [15:0] A, B, S;
logic Cin, Cout, V;

Full_Adder #(16) adder(A, B, Cin, S, Cout);

assign V = (A[15] === B[15]) && (A[15] !== S[15]);

initial begin
	// Caso 1
	A = 16'b0000000110000000;
	B = 16'b0000001101000000;
	Cin = 1'b0;
	#10;
	assert (S === 16'b0000010011000000) else $error("Case 1: S failed.");
	assert (Cout === 1'b0) else $error("Case 1: Cout failed.");
	assert (V === 1'b0) else $error("Case 1: Overflow failed.");
	#10;
	
	// Caso 2
	A = 16'b0000000110000000;
	B = 16'b1111110011000000;
	Cin = 1'b0;
	#10;
	assert (S === 16'b1111111001000000) else $error("Case 2: S failed.");
	assert (Cout === 1'b0) else $error("Case 2: Cout failed.");
	assert (V === 1'b0) else $error("Case 2: Overflow failed.");
	#10;
	
	// Caso 3
	A = 16'b1111111010000000;
	B = 16'b0000001101000000;
	Cin = 1'b0;
	#10;
	assert (S === 16'b0000000111000000) else $error("Case 3: S failed.");
	assert (Cout === 1'b1) else $error("Case 3: Cout failed.");
	assert (V === 1'b0) else $error("Case 3: Overflow failed.");
	#10;
	
	// Caso 4
	A = 16'b0111111111111111;
	B = 16'b0111111111111111;
	Cin = 1'b0;
	#10
	assert (S === 16'b1111111111111110) else $error("Case 4: S failed.");
	assert (Cout === 1'b0) else $error("Case 4: Cout failed.");
	assert (V === 1'b1) else $error("Case 4: Overflow failed.");
	#10;
end

endmodule 