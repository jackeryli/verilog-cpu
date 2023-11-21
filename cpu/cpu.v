module Cpu (clk, rst);

input clk;
input rst;

reg [31:0] instruction;
wire condition_met;

wire [3:0] flags;

// Instruction
reg [3:0] cond;
reg [3:0] opcode;
reg s;
reg [3:0] destination;
reg [3:0] source2;
reg [3:0] source1;
reg [4:0] shiftror;
reg [2:0] blank;
reg [2:0] shiftrorcontrol;
reg [15:0] immediate;

reg [7:0] pc; // Program Counter

// TODO
reg [15:0] pc_instruction_access;

// reg & memory
wire [31:0] reg_to_alu_source1;
wire [31:0] reg_to_alu_source2;

// alu & memorycontrol
wire [31:0] alu_result;

// memorycontrol & reg
wire [31:0] memorycontrol_to_reg;
wire ldr_sel;
wire [31:0] ldrdata_to_reg;

// memory & memorycontrol
wire rw;
wire [31:0] data_memory_to_memorycontrol;
wire [31:0] data_memorycontrol_to_memory;
wire address_bus_sel;
wire [15:0] address_bus_data_access;
wire [15:0] address_bus;

// Instruction Detail
// cond = instruction[31:28];
// opcode = instruction[27:24];
// s = instruction[23];
// destination = instruction[22:19];
// source2 = instruction[18:15];
// source1 = instruction[14:11];
// shiftror = instruction[10:6];
// shiftrorcontrol = instruction[2:0];

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        instruction <= 32'bz;
        pc <= 8'b0;
    end
    else begin
        instruction <= ram.memory[pc];
        
        {cond, opcode, s, destination, source2, source1, shiftror, blank, shiftrorcontrol} <= 32'bz;
        immediate <= 16'bz;

        cond <= instruction[31:28];

        if(cond != 4'b0000) begin
            {cond, opcode, s, destination, source2, source1, shiftror, blank, shiftrorcontrol} <= instruction;
            if(!condition_met) begin
                // Not satisfied. Don't execute this instruction
            end
            else begin
                {cond, opcode, s, destination, source2, source1, shiftror, blank, shiftrorcontrol} <= instruction;
                immediate <= instruction[18:3];
            end
        end
        else begin
            {cond, opcode, s, destination, source2, source1, shiftror, blank, shiftrorcontrol} <= instruction;
            immediate <= instruction[18:3];
        end
        
        pc <= pc + 1;
    end
    
end

RAM_2_16x32 ram(
    .data_input(data_memorycontrol_to_memory),
    .data_output(data_memory_to_memorycontrol),
    .RW(rw),
    .address(address_bus)
);

MemoryController mc (
  .Opcode(opcode),
  .Address(reg_to_alu_source1),  // Source1
  .Data(reg_to_alu_source2),     // Source2
  .Din(data_memory_to_memorycontrol),
  .LDRSel(ldr_sel),
  .AddressBusSel(address_bus_sel),
  .RW(rw),
  .LDRDataToDestReg(ldrdata_to_reg),
  .AddressBus(address_bus_data_access),
  .Dout(data_memorycontrol_to_memory)
);

Register register (
  .Destination(destination),
  .RegSource1(source1),
  .RegSource2(source2),
  .Din(memorycontrol_to_reg),
  .Source1(reg_to_alu_source1),
  .Source2(reg_to_alu_source2)
);

Mux_2x1 ldrmux(
    .In1(ldrdata_to_reg),
    .In2(alu_result),
    .Sel(ldr_sel),
    .Out(memorycontrol_to_reg)
);

Mux_2x1 #(.N(16)) addbusmux(
    .In1(address_bus_data_access),
    .In2(pc_instruction_access),
    .Sel(address_bus_sel),
    .Out(address_bus)
);


Alu alu(
    .In1(reg_to_alu_source1),
    .In2(reg_to_alu_source2),
    .Out(alu_result),
    .Opcode(opcode),
    .Cond(cond),
    .S(s),
    .SR_Cont(shiftrorcontrol),
    .SR_Bit(shiftror),
    .Flags(flags),
    .Immediate(immediate),
    .Condition_met(condition_met)
);

endmodule