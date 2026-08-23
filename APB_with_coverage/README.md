# APB Bus Transaction Coverage

A simple SystemVerilog testbench for an APB (Advanced Peripheral Bus) slave that adds **functional coverage** on top of a standard generator–driver–monitor–scoreboard verification environment.

## Files
- `apb_design.sv` – APB interface and DUT (simple memory-mapped slave)
- `apb_tb.sv` – Testbench: transaction, generator, driver, monitor, scoreboard, and coverage class

## What's Covered
Coverage is sampled in the monitor every time a transaction completes:
- **cp_addr** – address split into `low`, `mid`, `high` ranges
- **cp_write** – read vs write
- **cp_err** – slave error (`pslverr`) response
- **cross_addr_write** – address range × read/write
- **cross_addr_err** – address range × error response

## How to Run
1. Load `apb_design.sv` as the design file and `apb_tb.sv` as the testbench file on your simulator (e.g. EDA Playground with Xcelium/Questa).
2. Enable functional coverage in the simulator (e.g. `-coverage functional` for Xcelium).
3. Run — the console prints transaction logs and a final coverage report; `dump.vcd` is generated for waveform viewing.

## Result
With the default stimulus (only 2 addresses, no error injection), coverage shows expected gaps: `mid_addr`, `high_addr`, and the `error` bin are never hit — demonstrating how coverage analysis reveals untested scenarios that directed/random stimulus should be extended to cover.
