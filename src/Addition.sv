module Addition #(parameter N = 4)
					  (input  logic [N-1:0] A, B,
						output logic [N-1:0] S);

logic Cout, Overflow;
logic [N-1:0] OverflowResult;
logic [N-1:0] Result;

logic neg;
			
Full_Adder #(N) adder(.A(A), 
							 .B(B), 
							 .Cin(1'b0), 
							 .S(Result), 
							 .Cout(Cout));
							 
// Determinar si existe overflow
assign Overflow = (A[N-1] === B[N-1]) && (A[N-1] !== Result[N-1]);

// Verificacion Underflow, A y B son negativos y el resultado es positivo
assign neg = A[N-1] && B[N-1] && (Result[N-1] === 1'b0);

// Calculo de overlow positivo o negativo
assign OverflowResult = neg ? ({1'b1, {N-2{1'b0}}, 1'b1}) : ({1'b0, {N-1{1'b1}}});

// Determinar resultado final: overflow/underflow o resultado obtenido
assign S = Overflow ? OverflowResult : Result;

endmodule 