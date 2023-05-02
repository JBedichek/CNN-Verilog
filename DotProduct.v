// This module takes a kernel and input data and performs a dot product, for use
// In the convolution module
module DotProduct #(
  parameter KERNEL_SIZE, 
  parameter BIT_REP_IN=8, 
  parameter BIT_REP_OUT=8)( // Future version will support rounding for multiplication of
						  // Different types
  input signed [BIT_REP-1:0] kernel [KERNEL_SIZE-1][KERNEL_SIZE-1],
  input signed [BIT_REP_IN-1:0] in_data [KERNEL_SIZE-1:0][KERNEL_SIZE-1:0],
  output signed [BIT_REP-1:0] out_data,
);
  reg signed [BIT_REP-1:0] accumulator = 1'b0; // Initialize accumulator to zero
  always @* begin
    for (i = 0; i < KERNEL_SIZE; i = i+1) begin
      for (j = 0; j < KERNEL_SIZE; j = j+1) begin
        accumulator = accumulator + in_data[i][j] * kernel[i][j]; // Perform dot product
      end
    end
  end
  assign wire out_data = accumulator; 
endmodule
