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

// Registradores para inputs e outputs
reg [7:0] ui_in_reg, uio_in_reg;
reg [7:0] uo_out_reg, uio_out_reg;
reg [7:0] uo_out_reg_next, uio_out_reg_next;

// Registrador para o enable path
reg [7:0] uio_oe_reg;

// Ligando os inputs aos registradores com o clk
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

// Ligando os outputs aos registradores com o clk
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

// Logic for output path and enable path
always @* begin
    // Por padrão, outputs são 0.
    uo_out_reg_next = 8'b0;
    uio_out_reg_next = 8'b0;
    uio_oe_reg = 8'b0;

    // Se o circuito estiver ativo (ena == 1), os outputs recebem os inputs.
    if (ena) begin
        uo_out_reg_next = ui_in_reg;
        uio_out_reg_next = uio_in_reg;
        uio_oe_reg = 8'b11111111; // All bits high to enable output path
    end
end

// Assign outputs
assign uo_out = uo_out_reg;
assign uio_out = uio_out_reg;
assign uio_oe = uio_oe_reg;

endmodule
