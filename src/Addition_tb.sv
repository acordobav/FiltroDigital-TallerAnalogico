module Addition_tb();

logic [15:0] A, B, S;

Addition #(16) adder(A, B, S);

initial begin
	// Caso 1
	A = 16'b0000000110000000;
	B = 16'b0000001101000000;
	#10;
	assert (S === 16'b0000010011000000) else $error("Case 1: S failed.");
	#10;
	
	// Caso 2
	A = 16'b0000000110000000;
	B = 16'b1111110011000000;
	#10;
	assert (S === 16'b1111111001000000) else $error("Case 2: S failed.");
	#10;
	
	// Caso 3
	A = 16'b1111111010000000;
	B = 16'b0000001101000000;
	#10;
	assert (S === 16'b0000000111000000) else $error("Case 3: S failed.");
	#10;
	
	// Caso 4
	A = 16'b0111111111111111;
	B = 16'b0111111111111111;
	#10
	assert (S === 16'b0111111111111111) else $error("Case 4: S failed.");
	#10;
end

endmodule 