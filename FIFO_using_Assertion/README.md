
# Simple FIFO with Assertion-Based Testbench

## Introduction
This project implements a small synchronous FIFO (depth = 4, width = 8-bit) in SystemVerilog, along with a testbench that uses an **assertion** to automatically check for illegal behavior — specifically, writing to the FIFO while it is full.

## Files
- `fifo.sv` — the FIFO design (DUT)
- `fifo_tb.sv` — testbench that drives the FIFO and checks it with an assertion

## How to Run
**Icarus Verilog:**
```bash
iverilog -g2012 -o sim.out fifo.sv fifo_tb.sv
vvp sim.out
gtkwave dump.vcd
```

**Cadence Xcelium (e.g. on EDA Playground):**
```bash
xrun -sv fifo.sv fifo_tb.sv -access +rw
```
Enable **"Open EPWave after run"** to view the waveform.

## What the Test Does
1. Resets the FIFO.
2. Writes 4 values, completely filling it.
3. Deliberately attempts one more write while the FIFO is **full**.
4. The assertion catches this illegal write and prints an error.
5. A waveform (`dump.vcd`) is generated so the failure can be visually inspected — you can see `wr_en` high at the same time as `full`, while `mem[]`/`count` remain unaffected.

## Conclusion
Seeing the assertion fail on the deliberate illegal write is the **expected, correct** result — it proves the checker is working and the design correctly blocks writes when full. This is a simple example of how SystemVerilog assertions catch protocol violations automatically, without needing to manually inspect every waveform.
