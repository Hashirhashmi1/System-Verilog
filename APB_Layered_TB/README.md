# APB Bus Transaction Testbench

## Overview

This project implements a simple **APB bus transaction testbench using SystemVerilog OOP**.

## Features

* APB interface and memory-based DUT
* OOP-based transaction class
* Generator, Driver, Monitor, and Scoreboard
* Mailbox-based communication
* Virtual interface between testbench and DUT
* VCD waveform generation for EPWave
* Three APB transactions: two writes and one read

## Test Transactions

1. Write `A5` to address `04`
2. Read from address `04`
3. Write `5A` to address `08`

## Testbench Flow

`Generator → Mailbox → Driver → Virtual Interface → DUT → Monitor → Mailbox → Scoreboard`

## Files

* `design.sv` — APB interface and DUT
* `testbench.sv` — OOP-based layered testbench

## Result

The scoreboard compares the expected and actual read data. The read transaction passes when the data stored at the requested address matches the received data.

## Conclusion

This project demonstrates a basic layered APB verification environment using SystemVerilog OOP, mailboxes, virtual interfaces, and scoreboard-based checking.

