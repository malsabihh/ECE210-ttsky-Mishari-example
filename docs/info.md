<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This design implements a frequency encoder and decoder. The encoder uses a phase accumulator that adds the 8-bit input value `ui_in` every clock cycle. Whenever the accumulator overflows, a 1-bit spike is generated on `uo_out[0]`. Higher input values produce more frequent spikes.

The decoder estimates spike rate by counting how many spikes occur in a fixed 256-clock-cycle window. At the end of each window, the spike count is latched to an internal register and presented on `uo_out[7:1]` (with `uo_out[0]` still showing the spike).


## How to test

Run the provided cocotb simulation:

1. Start the container and enter it
2. Run:
    `cd test`
    `make -B`

The test drives `ui_in=128`, checks that at least one spike occurs on `uo_out[0]`, waits long enough for a full 256-cycle decode window, and then verifies that the decoded output (`uo_out >> 1`) is nonzero.

## External hardware

none
 
