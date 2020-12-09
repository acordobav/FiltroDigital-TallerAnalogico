module Multiplication_tb();
		
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

/*		
logic [15:0] A, B, Result;
	
Multiplication #(16) mult(A, B, Result);

initial begin
	
	// Caso 1
	A = 32'h00060C2F;
	B = 32'h0002009A;
	#10;
	assert (Result === 32'h000003A3) else $error("Case 1: Result failed.");
	#10;
	
	// Caso 2
	A = 32'hFFFFFECB;
	B = 32'h00060C2F;
	#10;
	assert (Result === 32'hFFF904E2) else $error("Case 2: Result failed.");
	#10;*/
	
	
end



endmodule 