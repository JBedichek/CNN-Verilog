'include DotProduct.v

// This module takes a kernel and a 2D input stream and returns a convoluted output 
// Using zero padding
module ZeroPaddingSpatialConvolution #(
  parameter BIT_REP_IN=8,     // Offers different number formats for input data, 				
  parameter BIT_REP_OUT=8,    // Supporting conversion
  parameter IN_LENGTH,
  parameter IN_WIDTH, 
  parameter KERNEL_SIZE)( 
  input signed [BIT_REP_IN] in_data [IN_LENGTH-1:0][IN_WIDTH-1:0],
  output signed [BIT_REP_OUT] out_data [IN_LENGTH-1:0][IN_WIDTH-1:0],
  input signed [BIT_REP_IN] kernel [KERNEL_SIZE-1:0][KERNEL_SIZE-1:0]
);
  // Padding is the number of zeros that needs to be added to the edge of the
  // Data so the kernel still has inputs at the edge pixels
  localparam integer PADDING = (KERNEL_SIZE-1)/2; 											  																	
  wire len_pad[PADDING-1:0][IN_WIDTH-1:0] = 1'b0; // 
  wire wid_pad[IN_LENGTH+2*PADDING-1:0][PADDING-1:0] = 1'b0;
  
  wire signed [BIT_REP_IN] padded_data[ IN_LENGTH+2*PADDING:0][IN_WIDTH+2*PADDING:0];
  assign wire padded_data = {len_pad, in_data, len_pad}; 
  											// Concatenate zeros to input data
  											// To prepare image for convolution
  reg signed[BIT_REP_IN-1:0] window [KERNEL_SIZE-1:0][KERNEL_SIZE-1:0]; 
  										    // The input window
  											// For performing dot products
  always @* begin
    for (i = 0; i < IN_LENGTH; i = i+1) begin
      for (j = 0; j < IN_WIDTH; j = j+1) begin
        // Get window of data to perform convolution on 
        window = padded_data [i+2*PADDING+:PADDING][j+2*PADDING+:PADDING]+
        padded_data [i+2*PADDING-:PADDING][j+2*PADDING-:PADDING]+
        padded_data [i+2*PADDING+:PADDING][j+2*PADDING-:PADDING]+
        padded_data [i+2*PADDING-:PADDING][j+2*PADDING+:PADDING];
        // Perform dot product
        DotProduct #(.KERNEL_SIZE(KERNEL_SIZE), .BIT_REP(BIT_REP_IN)) 
        instantiation(.kernel(kernel),.in_data(window), .out_data(out_data[i][j]));
      end
    end
    if(BIT_REP_IN != BIT_REP_OUT) begin
      assign wire out_data = out_data << BIT_REP_IN - BIT_REP_OUT; // Reformat number 
      												// Representation by shifting if
      												// Necessary (temporary method)    														  
  end
  
  endmodule