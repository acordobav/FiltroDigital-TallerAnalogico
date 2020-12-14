module Multiplication_tb();
		
logic [31:0] A, B, Result;
	
Multiplication #(32) mult(A, B, Result);

initial begin
	// Dos numeros positivos
	// Caso 1: 1.5 * 3.25 = 4.875
	A = 32'h18000;
	B = 32'h34000;
	#10;
	assert (Result === 32'h4E000) else $error("Case 1: Result failed.");
	#10;
	
	// Caso 2: 5.125 * 6.625 = 33.953125
	A = 32'h52000;
	B = 32'h6A000;
	#10;
	assert (Result === 32'h21F400) else $error("Case 2: Result failed.");
	#10;
	
	// Numero positivo y negativo
	// Caso 3: -10.5 * 35.3125
	A = 32'hFFF58000;
	B = 32'h235000;
	#10;
	assert (Result === 32'hFE8D3800) else $error("Case 3: Result failed.");
	#10;
	
	// Caso 4: 60.125 * -501.5 = -30152.6875
	A = 32'h3C2000;
	B = 32'hFE0A8000;
	#10;
	assert (Result === 32'h8A375000) else $error("Case 4: Result failed.");
	#10;
	
	// Caso overflow
	// Caso 5: 7500 * 8 = 60000 (bit 32 es un 1)
	A = 32'h1D4C0000;
	B = 32'h80000;
	#10;
	assert (Result === 32'h7FFFFFFF) else $error("Case 5: Result failed.");
	#10;
	
	// Caso 6: 15 * 15000 = 225000 (bit 32 es un 1)
	A = 32'hF0000;
	B = 32'h3A980000;
	#10;
	assert (Result === 32'h7FFFFFFF) else $error("Case 6: Result failed.");
	#10;
	
	// Caso underflow
	// Caso 7: 15 * -15000 = -225000 (bit 32 es un 1)
	A = 32'hF0000;
	B = 32'hC5680000;
	#10;
	assert (Result === 32'h80000001) else $error("Case 7: Result failed.");
	#10;
	
	// Caso 8: 7500 * -8 = -60000 (bit 32 es un 1)
	A = 32'h1D4C0000;
	B = 32'hFFF80000;
	#10;
	assert (Result === 32'h80000001) else $error("Case 8: Result failed.");
	#10;
	
	// Multiplicacion dos numeros negativos
	// Caso 9: -545.0125 * -15.5 = 8447.69375
	A = 32'hFDDEFCCD;
	B = 32'hFFF08000;
	#10;
	assert (Result === 32'h20FFB196) else $error("Case 9: Result failed.");
	#10;
	
	// Multiplicacion por cero
	// Caso 10: positivo por cero -> 3.25 * 0 = 0
	A = 32'h34000;
	B = 32'h0;
	#10;
	assert (Result === 32'h0) else $error("Case 10: Result failed.");
	#10;
	
	// Caso 11: negativo por cero -> 0 * -545.0125 = 0
	A = 32'h0;
	B = 32'hFDDEFCCD;;
	#10;
	assert (Result === 32'h0) else $error("Case 11: Result failed.");
	#10;
	
end

endmodule 