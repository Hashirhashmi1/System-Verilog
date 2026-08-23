# ALU Constrained-Random Testbench (SystemVerilog)

A simple SystemVerilog testbench that generates **constrained-random test vectors** for a 4-function ALU, computes the expected result internally, and dumps a waveform — all in a single file, no separate DUT required.

## File
- `alu_stimulus_tb.sv` — testbench (class + `module tb`)

##  Supported ALU Operations

| opcode | Operation |
|:------:|-----------|
| `00`   | ADD       |
| `01`   | SUB       |
| `10`   | AND       |
| `11`   | OR        |

##  Constraints

| Constraint      | Purpose                                  |
|-----------------|-------------------------------------------|
| `opcode_range`  | Restricts opcode to valid range `0–3`     |
| `no_zero`       | Prevents `a = 0` and `b = 0` together     |

## 🚀 How to Run (EDA Playground)

1. Paste `alu_stimulus_tb.sv` as the **testbench** file (no design file needed).
2. Select a simulator that supports SystemVerilog classes + `$dumpvars`
   (e.g. **Xcelium**, **ModelSim**, **Riviera-PRO**).
3. Enable **"Open EPWave after run"** to view the waveform.
4. Click **Run**.

## 📊 Sample Output

```
---- ALU Constrained Random Test Vectors ----
    a = 80    b = 8     opcode = 3   result = 88
    a = 232   b = 163   opcode = 0   result = 395
    a = 245   b = 239   opcode = 0   result = 484
    a = 199   b = 69    opcode = 2   result = 69
    a = 28    b = 148   opcode = 3   result = 156
```

- Console shows `a`, `b`, `opcode`, and computed `result` for each test.
- Waveform is saved to `waveform.vcd`, viewable in EPWave.

##  Notes
- `result` is **9 bits wide** to preserve ADD carry-out.
- Randomization and result computation both happen inside `module tb` — no DUT instantiation required.

##  Possible Extensions
- Add `assert`-based self-checking (PASS/FAIL)
- Connect to an actual ALU DUT for real verification
- Add more opcodes (XOR, shifts, etc.)

## 📄 License
Free to use for learning and coursework.
