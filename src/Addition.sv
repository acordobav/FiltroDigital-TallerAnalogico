module Addition #(parameter N = 4)
					  (input  logic [N-1:0] A, B,
						output logic [N-1:0] S);
logic Cout, Overflow;
logic [N-1:0] Result;
						
Full_Adder #(N) adder(.A(A), 
							 .B(B), 
							 .Cin(1'b0), 
							 .S(Result), 
							 .Cout(Cout));
							 
assign Overflow = (A[N-1] === B[N-1]) && (A[N-1] !== Result[N-1]);
assign S = Overflow ? {1'b0, {N-1{1'b1}}} : Result;

endmodule 