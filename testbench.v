`timescale 1ns / 1ps
module testbench;
  //parameters
  parameter N = 3;
  parameter SEQUENCE = 3'b101;
  // Inputs to DUT
  reg stream, clk, rst;
  wire out1;
  // Instantiate the sequence detector
  seq_det #(.n(N), .sequence(SEQUENCE)) inst1 (
    .data_stream(stream),
    .clock(clk),
    .reset(rst),
    .out(out1)
  );
  // 20ns clock
  always #10 clk = ~clk;
  // Input test stream
  reg [11:0] test = 12'b110101101011;
  integer i;
  initial begin
    clk = 0;
    stream = 0;
    rst = 1;
    #20;
    rst = 0;
    // Send bits one-by-one, MSB first
    for (i = 11; i >= 0; i = i - 1) begin
      stream = test[i];
      #20;  // one full clock cycle delay
    end
    // Extra time to see final output
    stream = 1'bx; // to prevent false output counting at the end
    // output will be high exactly 1 clock cycle after the required input has been detected, this is due to the working of non blocking assignments
    #40;
    $finish;
  end

endmodule
