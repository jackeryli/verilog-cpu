module Register_tb;

  reg [3:0] Destination;
  reg [3:0] RegSource1;
  reg [3:0] RegSource2;
  reg [31:0] Din;
  wire [31:0] Source1;
  wire [31:0] Source2;

  Register uut (
    .Destination(Destination),
    .RegSource1(RegSource1),
    .RegSource2(RegSource2),
    .Din(Din),
    .Source1(Source1),
    .Source2(Source2)
  );

  initial begin
    Destination = 4'b0001;
    RegSource1 = 4'b0001;
    RegSource2 = 4'b0010; 
    Din = 32'h00000001;

    #10;
    $display("Scenario 1: Save Din=1 to R1");
    $display("Source1 = %h", Source1);
    $display("Source2 = %h", Source2);

    #10;

    Destination = 4'b0010;
    RegSource1 = 4'b0001;
    RegSource2 = 4'b0010; 
    Din = 32'h00000002;

    #10;
    $display("Scenario 2: Save Din=2 to R2");
    $display("Source1 = %h", Source1);
    $display("Source2 = %h", Source2);

    #10;

    $finish;
  end

endmodule
