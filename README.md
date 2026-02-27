![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# Tiny Tapeout Verilog Project Template

# Frequency Encoder / Decoder (Rate Coding Neuromorphic Circuit)

## Overview

This project implements a neuromorphic frequency (rate) encoder and decoder using digital logic. The design converts an 8-bit input value into a spike train whose frequency is proportional to the input magnitude, then reconstructs an estimate of the input by measuring spike rate over time.

The circuit demonstrates the principle of rate coding: where information is represented by spike frequency rather than amplitude.

## Architecture

The design consists of two main blocks:

### Frequency Encoder
The encoder uses a phase accumulator:

- Each clock cycle the accumulator adds the input value `ui_in`.
- When the accumulator overflows, a spike is generated on `uo_out[0]`.
- Larger input values produce higher spike frequencies.

This is like the integrate-and-fire neuron behavior mechanism.

### Frequency Decoder
The decoder estimates spike rate using a fixed time window:

- Spikes are counted over a 256 clock cycle window.
- At the end of the window, the spike count is latched.
- The decoded value is output on `uo_out[7:1]`.

This demonstrates temporal integration similar to neural population decoding.

## How It Works

1. Input value determines spike frequency.
2. Spikes are generated using accumulator overflow.
3. Decoder counts spikes in a 256 cycle.
4. Output approximates the original input magnitude.

## How to Test

Run simulation using the provided cocotb test
