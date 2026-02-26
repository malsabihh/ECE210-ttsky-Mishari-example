/*
 * Copyright (c) 2024 Mishari Alsabih
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

      // Frequency encoder using an 8-bit phase accumulator
  reg  [8:0] acc;       
  reg        spike;
  reg [7:0] win_ctr;     
  reg [7:0] spike_ctr;   
  reg [7:0] decoded;    
  wire [8:0] sum;
  assign sum = acc + {1'b0, ui_in};

  // Drive outputs
  assign uo_out  = {decoded[7:1], spike};
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  always @(posedge clk) begin
    if (!rst_n) begin
      acc   <= 9'd0;
      spike <= 1'b0;
      win_ctr   <= 8'd0;
      spike_ctr <= 8'd0;
      decoded   <= 8'd0;
    end else begin
      // overflow generates a spike
      acc   <= sum;
      spike <= sum[8];
      win_ctr <= win_ctr + 8'd1;

      if (sum[8])
        spike_ctr <= spike_ctr + 8'd1;

      if (win_ctr == 8'hFF) begin
        decoded   <= spike_ctr;
        spike_ctr <= 8'd0;
        win_ctr   <= 8'd0;
      end
    end
  end

  
  wire _unused = &{ena, uio_in, 1'b0};
 

endmodule


