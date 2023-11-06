module MemoryController (
  input [3:0] Opcode,
  input [31:0] Address, // Source1
  input [31:0] Data,    // Source2
  input [31:0] Din,
  output reg LDRSel,
  output reg AddressBusSel,
  output reg RW,
  output reg [31:0] LDRDataToDestReg,
  output reg [31:0] AddressBus,
  output reg [31:0] Dout
);

  // TODO: LDR MUX

  always @(Opcode or Address or Data or Din) begin
    LDRSel = 1'b0;
    AddressBusSel = 1'b0;
    LDRDataToDestReg = 32'bz;
    AddressBus = 32'bz;
    Dout = 32'bz;
    RW = 1'bz;

    // LDR: source1 points to the address of the data in the RAM.
    if (Opcode == 4'b1101) begin
      LDRSel = 1;
      AddressBusSel = 1;
      AddressBus = Address;
      RW = 0;
      LDRDataToDestReg = Din;
    end
    // STR
    // source 1 points to the address
    // source 2 points to the register containing the data to be written in the RAM
    else if (Opcode == 4'b1110) begin
      AddressBusSel = 1;
      RW = 1;
      AddressBus = Address;
      Dout = Data;
    end
  end
endmodule
