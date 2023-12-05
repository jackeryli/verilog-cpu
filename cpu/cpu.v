module Cpu (clk, rst);

input clk;
input rst;

reg [2:0] state, next_state;
parameter [2:0] LOAD=3'b000, FETCH=3'b001, DECODE=3'b010, EXECUTE=3'b011;

reg [7:0] pc, next_pc; // Program Counter

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
// source1 = instruction[18:15];
// source2 = instruction[14:11];
// shiftror = instruction[10:6];
// shiftrorcontrol = instruction[2:0];

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        state <= LOAD;
        pc <= 0;
    end
    else begin
        state <= next_state;
        pc <= next_pc;
    end
end

always@(*) begin
    cond = 4'bx;
    opcode = 4'bx;
    s = 1'bx;
    destination = 4'bx;
    source1 = 4'bx;
    source2 = 4'bx;
    shiftror = 5'bx;
    shiftrorcontrol = 3'bx;
    case(state)
    LOAD: begin
        next_state = FETCH;
        next_pc = pc;
    end
    FETCH: begin
        // Read instruction from memory
        instruction = ram.memory[pc];
        next_state = DECODE;
        next_pc = pc;
    end
    DECODE: begin
        cond = instruction[31:28];
        if(cond != 4'b0000 && !condition_met) begin
            opcode = 4'b1111; // NOP
            next_state = EXECUTE;
            next_pc = pc;
        end
        else begin
            next_state = EXECUTE;
            next_pc = pc;
        end
    end
    EXECUTE: begin
        if(opcode == 4'b1111) begin
            // NOP do nothing
        end
        else begin
            {cond, opcode, s, destination, source1, source2, shiftror, blank, shiftrorcontrol} = instruction;
            // When executing LDR, destination should be source1
            if(instruction[27:24] == 4'b1101) begin
                destination = instruction[18:15];
            end
            // When executing STR, destination should be source1
            else if (instruction[27:24] == 4'b1110) begin
                destination = instruction[18:15];
            end
            immediate = instruction[18:3];
        end
        
        next_state = FETCH;
        // pc increment
        next_pc = pc + 1;
    end
    default: begin
        next_state = FETCH;
        next_pc = pc;
    end
    endcase
end

RAM_2_16x32 ram(
    .data_input(data_memorycontrol_to_memory),
    .data_output(data_memory_to_memorycontrol),
    .RW(rw),
    .address(address_bus)
);

MemoryController mc (
  .Opcode(opcode),
  .Address(reg_to_alu_source2),  // source2 is address
  .Data(reg_to_alu_source1),     // source1 is data
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