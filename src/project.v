/*
 * Copyright (c) 2024 Lucas Augusto dos Santos Anadão
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// just a stub to keep the Tiny Tapeout tools happy

module tt_um_teste_tinytapeout (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
