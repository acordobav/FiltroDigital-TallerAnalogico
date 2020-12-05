module Multiplication #(parameter N = 16)
							  (input logic  [N-1:0] A, B,
							   output logic [N-1:0] Result);
										
logic [(N*2)-1:0] result;				
logic [N-1:0] high, mid, low; 							
logic [(N/2)-1:0] a, b, c, d;

assign a = A[N-1] ? ~A[N-1:(N/2)] : A[N-1:(N/2)];
assign b = A[(N/2)-1:0];
assign c = B[N-1] ? ~B[N-1:(N/2)] : B[N-1:(N/2)];
assign d = B[(N/2)-1:0];

assign high = (a * c);
assign mid  = (a * d) + (b * c);
assign low  = (b * d); 

assign result = (high << (N/2)) + mid + (low >> (N/2));

always_comb begin
	if(result[(N*2)-1:N] === {{N{1'b0}}}) begin
		// No existe overflow
		Result <= (A[N-1] || B[N-1]) ? {~result[N-1:(N/2)], result[(N/2)-1:0]} : result[N-1:0];
	end else begin
		// Existe overflow
		Result <= {1'b0, {N-1{1'b1}}};
	end
	
	// Multiplicacion por cero
	if(A === 0 || B === 0) Result <= {N{1'b0}};
end
endmodule 