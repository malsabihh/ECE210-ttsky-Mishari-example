# Frequency Encoder / Decoder

## Overview

This project implements a neuromorphic frequency encoder and decoder using digital logic. The design converts an 8-bit input value into a spike train whose frequency is proportional to the input magnitude, then reconstructs an estimate of the input by measuring spike rate over time.

The circuit demonstrates information by spike frequency rather than amplitude.

## Architecture

The design consists of two main blocks:

### Frequency Encoder

- Each clock cycle the accumulator adds the input value `ui_in`.
- When the accumulator overflows, a spike is generated on `uo_out[0]`.
- Larger input values produce higher spike frequencies.

This is like integrate-and-fire neuron behavior.

### Frequency Decoder
The decoder estimates spike rate using a fixed time window:

- Spikes are counted over a 256 clock cycle window.
- At the end of the window, the spike count is latched.
- The decoded value is output on `uo_out[7:1]`.


## How It Works

1. Input value determines spike frequency.
2. Spikes are generated using accumulator overflow.
3. Decoder counts spikes in a 256 cycle window.
4. Output approximates the original input magnitude.


## How to Test

Run simulation using the provided cocotb test:

