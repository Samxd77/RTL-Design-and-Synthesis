// Asynchronous Reset D Flip-Flop
// This module demonstrates a D flip-flop with an asynchronous reset
// The reset signal overrides the clock and immediately forces q to 0

module dff_asyncres (
  input clk,              // Clock input (rising edge triggered)
  input async_reset,      // Asynchronous reset (active high)
  input d,                // Data input
  output reg q            // Output (stores the flip-flop state)
);

  always @ (posedge clk, posedge async_reset)
    if (async_reset)
      q <= 1'b0;         // Reset output to 0
    else
      q <= d;            // Capture input on clock rising edge

endmodule
