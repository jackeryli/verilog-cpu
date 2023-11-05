module reg_bank_16x32(data_out,wr,rd_addr,data_in);
	input [15:0] wr;
	input [3:0] rd_addr;
	input [31:0] data_in;
	output [31:0] data_out;

reg [31:0] registers[15:0];
integer i;

always @* 
begin
	for (i=1; i<16; i=i+1)
		if (wr[i])
			registers[i] = data_in;
	
end

assign data_out=registers[rd_addr];
endmodule