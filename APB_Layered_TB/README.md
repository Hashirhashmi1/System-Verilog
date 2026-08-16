# APB Bus Transaction Testbench

## Overview
This project implements a simple APB bus transaction testbench using SystemVerilog OOP concepts.

## Features
- APB interface and memory-based DUT
- OOP-based transaction class
- Generator, Driver, Monitor, and Scoreboard
- Mailbox-based communication
- Virtual interface between testbench and DUT
- VCD waveform generation for EPWave
- Four APB transactions with read-back verification

## Test Transactions
1. Write `A5` to address `04`
2. Read from address `04` and verify the data
3. Write `5A` to address `08`
4. Read from address `08` and verify the data

## Testbench Flow
`Generator → Mailbox → Driver → Virtual Interface → DUT → Monitor → Mailbox → Scoreboard`

## Verification
The scoreboard stores the expected data during write transactions and compares it with the actual data received during read transactions.

Both read transactions are expected to produce a `READ PASS` result when the expected and actual data match.

## Files
- `design.sv` — APB interface and DUT
- `testbench.sv` — OOP-based layered testbench

## Result
The testbench successfully performs two write and two read transactions. The scoreboard verifies both read operations and reports PASS when the expected and actual data are equal.

## Conclusion
This project demonstrates a basic layered APB verification environment using SystemVerilog OOP, mailboxes, virtual interfaces, monitoring, and scoreboard-based data verification.

