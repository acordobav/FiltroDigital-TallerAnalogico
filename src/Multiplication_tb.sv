module Multiplication_tb();/* #(parameter N = 4)
							  (input logic [N-1:0] A, B,
							   output logic [N-1:0] M);*/
								
logic [15:0] A, B, Result;
	
Multiplication #(16) mult(A, B, Result);

initial begin
	// Caso 1
	A = 16'b0000000110000000;
	B = 16'b0000001101000000;
	#10;
	assert (Result === 16'b0000010011100000) else $error("Case 1: Result failed.");
	#10;
	
	// Caso 2
	A = 16'b1111111010000000;
	B = 16'b0000001101000000;
	#10;
	assert (Result === 16'b1111101111100000) else $error("Case 2: Result failed.");
	#10;
	
	// Caso 3
	A = 16'b0111111110000000;
	B = 16'b0000010101000000;
	#10;
	assert (Result === 16'b0111111111111111) else $error("Case 3: Result failed.");
	#10;
	
	// Caso 4
	B = 16'b1111111010000000;
	A = 16'b0000001101000000;
	#10;
	assert (Result === 16'b1111101111100000) else $error("Case 4: Result failed.");
	#10;
end
endmodule 