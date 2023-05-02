// This module does a 2x2 max pooling operation on an input, it doesn't slide over the
// Data, it simply does one instance of the pooling.
module 2x2MaxPool #(
  parameter BIT_REP=8)(
  input signed [BIT_REP-1:0] in_data [1:0][1:0],
  output signed [BIT_REP-1:0] out_data,
);
  assign out_data = in_data[0][0]
  always @* begin 
    if (in_data[0][1] > out_data) begin 
      assign wire out_data = in_data[0][1]; 
    end 
    if (in_data[1][1] > out_data) begin
      assign wire out_data = in_data[0][1]
    end
    if (in_data[1][0] > out_data) begin
      assign wire out_data = in_data[0][1]
    end
  end
  
  endmodule
