module DigitalFilter(input  logic clk, rst, 
							input  logic [31:0] data_in, a1, b0, b1,
							output logic [31:0] yn);

logic [31:0] xn, wn, wn1, wn1_a1, wn1_b1, wn_b0;
		  
Addition #(32) adder1(.A(data_in), 
							 .B(32'h40FFFF), 
							 .S(xn));

Addition #(32) adder2(.A(xn), 
							 .B(wn1_a1), 
							 .S(wn));
								
Register #(32) reg1(.CLK(clk),
						  .RST(rst),
						  .EN(1'b1),
						  .Data_In(wn),
						  .Data_Out(wn1));
						  
Multiplication #(32) mult1(.A(wn1),
								   .B(a1),
								   .Result(wn1_a1));

Multiplication #(32) mult2(.A(wn1),
								   .B(b1),
								   .Result(wn1_b1));

Multiplication #(32) mult3(.A(wn),
								   .B(b0),
								   .Result(wn_b0));

Addition #(32) adder3(.A(wn_b0), 
							 .B(wn1_b1), 
							 .S(yn));			  

endmodule 