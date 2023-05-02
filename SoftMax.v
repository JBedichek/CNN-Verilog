// This module creates a look up table that holds approximations of the exponential
// Function used in the SoftMax transformation
module ExpLUT #(
  parameter TABLE_SIZE=256, 
  parameter BIT_REP_IN=8,
  parameter BIT_REP_EXP=8)
 reg signed input [BIT_REP_IN-1:0]in_data
(wire signed output [BIT_REP_IN-1:0]out_data[BIT_REP_IN-1:0]
  );
  wire signed [BIT_REP_EXP-1:0]exp_table[TABLE_SIZE-1:0];
  initial begin
    for (i = 0; i < TABLE_SIZE; i = i+1) begin
      assign exp_table[i] = $exp(i);
    end
  end
  always @* begin
    assign out_data = exp_table[in_data];
  end
  
  endmodule

// This module takes activations from a previous layer and puts them through a SoftMax
// Function
module SoftMax#(
  parameter BIT_REP=8,
  parameter IN_LENGTH,)(
  input wire signed [BIT_REP-1:0]in_data[IN_LENGTH:0]
  output wire signed [BIT_REP-1:0]out_data[IN_LENGTH:0]
);
  signed reg [BIT_REP-1:0] exp_sum = 1'b0
  signed reg [BIT_REP-1:0] temp_exp
  initial begin
    for(i = 0; i < IN_LENGTH; i = i+1) begin
      ExpLUT(.in_data(in_data[i]), .out_data(temp_exp))
      exp_sum = exp_sum + temp_exp
    end
    for(i = 0; i < IN_LENGTH; i = i+1) begin
      ExpLUT(.in_data(in_data[i]), .out_data(temp_exp))
      assign out_data[i] = temp_exp / exp_sum 
      end
  end
  
  endmodule
    