`timescale 1 ns / 1 ns

module Filter();

int f_highpass, f_lowpass;

logic clk, rst;
logic [14:0] address;
logic [31:0] rom_out, yn_low, yn_high; 

assign rst = 0;

Rom rom(.address(address), 
        .clock(clk), 
		  .q(rom_out));

// Filtro Paso Bajo		  
DigitalFilter lowpass_filter(.clk(clk),
									  .rst(rst),
									  .data_in(rom_out),
									  .a1(32'hFEFF),
									  .b0(32'h80),
									  .b1(32'h80),
									  .yn(yn_low));

// Filtro Paso Alto		  
DigitalFilter highpass_filter(.clk(clk),
									   .rst(rst),
									   .data_in(rom_out),
									   .a1(32'hC035),
									   .b0(32'hE01A),
									   .b1(32'hFFFF1FE6),
									   .yn(yn_high));
		
initial begin
	clk = 1;
	address = 0;
	
	f_highpass = $fopen("highpass.txt","w");
	f_lowpass = $fopen("lowpass.txt","w");
	
	wait(address==20002);
	$fclose(f_highpass);  
	$fclose(f_lowpass);
	$finish;
end 

// Escritura de los datos de salida en un txt
always @(negedge clk)
begin
	address = address + 1;
	//$display("PC:inst_mem_address: %d, data_mem_address: %d, data_mem_in_data: %d", 
	$fwrite(f_highpass, "%b ", yn_high+32'h3FFFFF);
	$fwrite(f_lowpass,  "%b ", yn_low+32'h3FFFFF);
end

always
	#5 clk = !clk;
		

		  
		  
endmodule 