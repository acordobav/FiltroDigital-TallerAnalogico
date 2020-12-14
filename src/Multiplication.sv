module Multiplication #(parameter N = 16)
							  (input logic  [N-1:0] A, B,
							   output logic [N-1:0] Result);
logic neg;
								
logic [N-1:0] Am, Bm;
								
assign Am = A[N-1] ? (~A)+1 : A; // Complemento a 2
assign Bm = B[N-1] ? (~B)+1 : B; // Complemento a 2
								
logic [(N*2)-1:0] result;				
logic [N-1:0] high, mid, low; 							
logic [(N/2)-1:0] a, b, c, d;

assign a = Am[N-1:(N/2)];
assign b = Am[(N/2)-1:0];
assign c = Bm[N-1:(N/2)];
assign d = Bm[(N/2)-1:0];

assign high = (a * c);
assign mid  = (a * d) + (b * c);
assign low  = (b * d); 

assign result = (high << (N/2)) + mid + (low >> (N/2));

assign neg = (A[N-1] || B[N-1]) && (A[N-1] !== B[N-1]); 

always_comb begin
	if(result[(N*2)-1:N] === {{N{1'b0}}}) begin
		// No existe overflow
		Result <= neg ? (~result[N-1:0])+1 : result[N-1:0];
	end else begin
		// Existe overflow
		Result <= neg ? ({1'b1, {N-2{1'b0}}, 1'b1}) : {1'b0, {N-1{1'b1}}};
	end
	
	// Multiplicacion por cero
	if(A === 0 || B === 0) Result <= {N{1'b0}};
end
endmodule 