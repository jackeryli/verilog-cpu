module tb_MemoryController;

  reg [3:0] Opcode;
  reg [31:0] Address;
  reg [31:0] Data;

  wire LDRSel;
  wire AddressBusSel;
  wire RW;
  wire [31:0] LDRDataToDestReg;
  wire [31:0] AddressBus;
  wire [31:0] DataBus;

  // Instantiate the MemoryController module
  MemoryController mem_ctrl (
    .Opcode(Opcode),
    .Address(Address),
    .Data(Data),
    .LDRSel(LDRSel),
    .AddressBusSel(AddressBusSel),
    .RW(RW),
    .LDRDataToDestReg(LDRDataToDestReg),
    .AddressBus(AddressBus),
    .DataBus(DataBus)
  );

  // Testbench stimulus
  initial begin
    Opcode = 4'b1101; // Example LDR opcode
    Address = 32'h12345678; // Example address for LDR
    Data = 32'h9abcdef0; // Example data for LDR

    // LDR Test
    $display("Testing LDR:");
    $display("Opcode: 4'b%b", Opcode);
    $display("Address: 32'h%h", Address);
    $display("Data: 32'h%h", Data);
    
    #10; // Wait for some time
    
    $display("LDRSel: %b", LDRSel);
    $display("AddressBusSel: %b", AddressBusSel);
    $display("RW: %b", RW);
    $display("LDRDataToDestReg: 32'h%h", LDRDataToDestReg);
    $display("AddressBus: 32'h%h", AddressBus);
    $display("DataBus: 32'h%h", DataBus);
    
    // You can add more test scenarios here

    $finish; // End simulation
  end

endmodule
