module ldr_tb();

    // Inputs for ALU
    reg [31:0] In1;
    reg [31:0] In2;
    reg [3:0] Opcode;
    reg [4:0] SR_Bit;
    reg [2:0] SR_Cont;
    reg S;
    reg [15:0] Immediate;

    // Inputs for Memory Control
    reg [31:0] Din;

    // Output for ALU
    wire [31:0] Out;
    wire [3:0] Flags;

    // Output for Memory Control
    wire LDRSel;
    wire AddressBusSel;
    wire RW;
    wire [31:0] LDRDataToDestReg;
    wire [31:0] AddressBus;
    wire [31:0] Dout;

    // Output for LDRMux to Register
    wire [31:0] LDRMuxOutput;

    // Instantiate the Unit Under Test (UUT)
    alu_simple uut (
        .In1(In1), 
        .In2(In2), 
        .Out(Out), 
        .Opcode(Opcode), 
        .SR_Cont(SR_Cont), 
        .SR_Bit(SR_Bit),
        .S(S),
        .Flags(Flags),
        .Immediate(Immediate)
    );

    // Instantiate the MemoryController module
    MemoryController mem_ctrl (
        .Opcode(Opcode),
        .Address(In1),
        .Data(In2),
        .Din(Din),
        .LDRSel(LDRSel),
        .AddressBusSel(AddressBusSel),
        .RW(RW),
        .LDRDataToDestReg(LDRDataToDestReg),
        .AddressBus(AddressBus),
        .Dout(Dout)
    );

    Mux_2x1 ldr_mux (.In1(LDRDataToDestReg), .In2(Out), .Sel(LDRSel), .Out(LDRMuxOutput));

    initial begin
        // Initialize Inputs for ALU
        In1 = 0;
        In2 = 0;
        Opcode = 0;
        SR_Bit = 0;
        SR_Cont = 0;
        S = 1;

        // Initialize Inputs for Memory Control
        Din = 32'h12345678; // Example data for databus

        // Wait for global reset
        #100;

        // Test LDR
        $display("Test LDR");
        Opcode = 4'b1101;   // LDR Opcode
        In1 = 30;
        #10;
        $display("LDRSel: %b", LDRSel);
        $display("AddressBusSel: %b", AddressBusSel);
        $display("RW: %b", RW);
        $display("LDRDataToDestReg: 32'h%h", LDRDataToDestReg);
        $display("AddressBus: 32'h%h", AddressBus);
        $display("Din: 32'h%h", Din);
        $display("Dout: 32'h%h", Dout);
        $display("LDRMuxOutput: 32'h%h", LDRMuxOutput);

        // Test STR
        $display("Test STR");
        Opcode = 4'b1110;   // STR Opcode
        In1 = 30;
        #10;
        $display("LDRSel: %b", LDRSel);
        $display("AddressBusSel: %b", AddressBusSel);
        $display("RW: %b", RW);
        $display("LDRDataToDestReg: 32'h%h", LDRDataToDestReg);
        $display("AddressBus: 32'h%h", AddressBus);
        $display("Din: 32'h%h", Din);
        $display("Dout: 32'h%h", Dout);
        $display("LDRMuxOutput: 32'h%h", LDRMuxOutput);


        
        #10;


    end


endmodule