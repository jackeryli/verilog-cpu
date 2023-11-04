module MemoryController (
  input [3:0] Opcode,
  input [31:0] Address, // Source1
  input [31:0] Data,    // Source2
  output reg LDRSel,
  output reg AddressBusSel,
  output reg RW,
  output reg [31:0] LDRDataToDestReg,
  output reg [31:0] AddressBus,
  inout [31:0] DataBus
);

  always @(*) begin
    LDRSel = 0;
    AddressBusSel = 0;
    LDRDataToDestReg = 32'b0;
    AddressBus = 32'b0;
    
    // LDR: source1 points to the address of the data in the RAM.
    if (Opcode == 4'b1101) begin
      LDRSel = 1;
      AddressBusSel = 1;
      AddressBus = Address;
      RW = 0;
      LDRDataToDestReg = DataBus;
    end
    // STR
    // source 1 points to the address
    // source 2 points to the register containing the data to be written in the RAM
    else if (Opcode == 4'b1110) begin
      AddressBusSel = 1;
      RW = 1;
      AddressBus = Address;
    end
  end

  assign DataBus = (Opcode == 4'b1110) ? Data : 32'bz; 
endmodule
