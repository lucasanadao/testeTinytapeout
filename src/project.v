/*
 * Copyright (c) 2024 Lucas Augusto dos Santos Anadão
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_teste_tinytapeout (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

reg [7:0] ui_in_reg, uio_in_reg;
reg [7:0] uo_out_reg, uio_out_reg;
reg [7:0] uo_out_reg_next, uio_out_reg_next;

reg [7:0] uio_oe_reg;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        ui_in_reg <= 8'b0;
        uio_in_reg <= 8'b0;
    end
    else begin
        ui_in_reg <= ui_in;
        uio_in_reg <= uio_in;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        uo_out_reg <= 8'b0;
        uio_out_reg <= 8'b0;
    end
    else begin
        uo_out_reg <= uo_out_reg_next;
        uio_out_reg <= uio_out_reg_next;
    end
end

always @* begin
    // By default, outputs are 0
    uo_out_reg_next = 8'b0;
    uio_out_reg_next = 8'b0;
    uio_oe_reg = 8'b0;

    // If enabled, sum inputs and set all outputs to 0
    if (ena) begin
        // Example: sum the first 4 bits of ui_in
        uo_out_reg_next = ui_in_reg[3:0] + ui_in_reg[7:4];
        uio_out_reg_next = 8'b0; // All outputs are 0
        uio_oe_reg = 8'b11111111; // All bits high to enable output path
    end
end

// Assign outputs
assign uo_out = uo_out_reg;
assign uio_out = uio_out_reg;
assign uio_oe = uio_oe_reg;

endmodule
