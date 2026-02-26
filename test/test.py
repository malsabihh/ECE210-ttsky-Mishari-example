# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer, RisingEdge


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Start clock
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    dut._log.info("Reset")
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    await Timer(100, units="ns")
    dut.rst_n.value = 1

    dut._log.info("Test encoder produces spikes")

    # Drive a nonzero input so the encoder produces spikes
    dut.ui_in.value = 128

    # Look for at least one spike on uo_out[0]
    spike_seen = False
    for _ in range(300):
        await RisingEdge(dut.clk)
        if int(dut.uo_out.value) & 1:
            spike_seen = True
            break

    assert spike_seen

    await ClockCycles(dut.clk, 260)

    decoded = int(dut.uo_out.value) >> 1
    assert decoded > 0
