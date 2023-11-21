module Register (
  input [3:0] Destination,
  input [3:0] RegSource1,
  input [3:0] RegSource2,
  input [31:0] Din,
  output reg [31:0] Source1,
  output reg [31:0] Source2
);

reg [31:0] registers[0:15];
wire [15:0] en;
integer i;

// ADD R1 R2 R3

Decoder_4to16 decoder(.out(en), .sel(Destination));


always@(*) begin
    for (i=1; i<16; i=i+1)
		if (en[i])
			registers[i] = Din;
end

assign Source2 = registers[RegSource1];
assign Source1 = registers[RegSource2];

endmodule
