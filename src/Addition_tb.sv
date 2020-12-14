module Addition_tb();

logic [31:0] A, B, S;

Addition #(32) adder(A, B, S);

initial begin
	// Caso 1: 2.5 + 1.3
	A = 32'h3FFFFF;
	B = 32'h2147AD;
	#10;
	assert (S === 32'h6147AC) else $error("Case 1: S failed.");
	#10;
	
	// Caso 2: 1.7 + 0.23 
	A = 32'h2B851E;
	B = 32'h5E353;
	#10;
	assert (S === 32'h316871) else $error("Case 2: S failed.");
	#10;
	
	// Caso 3: 3.23 + 1.07 
	A = 32'h52B020;
	B = 32'h1B6459;
	#10;
	assert (S === 32'h6E1479) else $error("Case 3: S failed.");
	#10;
	
	// Caso 4: 4.035 + 1.078
	A = 32'h674BC6;
	B = 32'h1B98C7;
	#10;
	assert (S === 32'h82E48D) else $error("Case 4: S failed.");
	#10;
	
	// Caso 5: Caso donde no se debe verificar el carry
	// Numero negativo + positivo
	A = 32'hFFD99999;
	B = 32'h3FFFFF;
	#10;
	assert (S === 32'h199998) else $error("Case 5: S failed.");
	#10;
	
	// Caso 6: Caso donde dos numeros positivos dan uno negativo
	// Overflow positivo
	A = 32'h7FFFFFFF;
	B = 32'h7FFFFFFF;
	#10;
	assert (S === 32'h7FFFFFFF) else $error("Case 6: S failed.");
	#10;
	
	// Caso 7: Carry negativo
	A = 32'h7FFD99999;
	B = 32'h803FFFFF;
	#10;
	assert (S === 32'h80199998) else $error("Case 7: S failed.");
	#10;
	
	// Caso 8: Caso underflow
	A = 32'h80000001;
	B = 32'h80000000;
	#10;
	assert (S === 32'h80000001) else $error("Case 8: S failed.");
	#10;
	
end

endmodule 