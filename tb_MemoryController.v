module tb_MemoryController;

  reg [3:0] Opcode;
  reg [31:0] Address;
  reg [31:0] Data;
  reg [31:0] Din;

  wire LDRSel;
  wire AddressBusSel;
  wire RW;
  wire [31:0] LDRDataToDestReg;
  wire [31:0] AddressBus;
  wire [31:0] Dout;

  // Instantiate the MemoryController module
  MemoryController mem_ctrl (
    .Opcode(Opcode),
    .Address(Address),
    .Data(Data),
    .Din(Din),
    .LDRSel(LDRSel),
    .AddressBusSel(AddressBusSel),
    .RW(RW),
    .LDRDataToDestReg(LDRDataToDestReg),
    .AddressBus(AddressBus),
    .Dout(Dout)
  );

  // Testbench stimulus
  initial begin
    Opcode = 4'b1101; // Example LDR opcode
    Address = 32'h12345678; // Example address for LDR
    Data = 32'h9abcdef0; // Example data for LDR
    Din = 32'h12345678; // Example data for databus

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
    $display("Din: 32'h%h", Din);
    $display("Dout: 32'h%h", Dout);
    
    // STR Test
    Opcode = 4'b1110;

    $display("Testing STR:");
    $display("Opcode: 4'b%b", Opcode);
    $display("Address: 32'h%h", Address);
    $display("Data: 32'h%h", Data);
    
    #10; // Wait for some time
    
    $display("LDRSel: %b", LDRSel);
    $display("AddressBusSel: %b", AddressBusSel);
    $display("RW: %b", RW);
    $display("LDRDataToDestReg: 32'h%h", LDRDataToDestReg);
    $display("AddressBus: 32'h%h", AddressBus);
    $display("Din: 32'h%h", Din);
    $display("Dout: 32'h%h", Dout);

    // Test other opcode
    Opcode = 4'b0001;

    $display("Testing Other opcode:");
    $display("Opcode: 4'b%b", Opcode);
    $display("Address: 32'h%h", Address);
    $display("Data: 32'h%h", Data);
    
    #10; // Wait for some time
    
    $display("LDRSel: %b", LDRSel);
    $display("AddressBusSel: %b", AddressBusSel);
    $display("RW: %b", RW);
    $display("LDRDataToDestReg: 32'h%h", LDRDataToDestReg);
    $display("AddressBus: 32'h%h", AddressBus);
    $display("Din: 32'h%h", Din);
    $display("Dout: 32'h%h", Dout);

    

    $finish; // End simulation
  end

endmodule
