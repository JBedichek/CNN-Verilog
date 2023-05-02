// This module takes up to a 3D tensor of input data and performs
// A rectified linear unit activation function
module ReLU #(
  parameter IN_WIDTH, 
  parameter IN_LENGTH, 
  parameter BIT_REP=8)(
  input wire signed [BIT_REP-1:0] in_data [IN_WIDTH-1:0][IN_LENGTH-1:0][IN_DEPTH-1:0],
  output wire signed [BIT_REP-1:0] out_data [IN_WIDTH-1:0][IN_LENGTH-1:0][IN_DEPTH-1:0],
);
  always @* begin
    for (i = 0; i < IN_WIDTH; i = i+1) begin
      for (j = 0; j < IN_LENGTH; j = j+1) begin
        for (k = 0; k < IN_DEPTH; k = k+1) begin // Supports depth dimension for 
        								// Multi-channel data
          if (in_data[i][j][k] > 0) begin
            assign out_data[i][j][k] = in_data[i][j][k];
          end else begin
            assign out_data[i][j][k] = 0; 
          end
        end
      end
    end
  end
  
endmodule