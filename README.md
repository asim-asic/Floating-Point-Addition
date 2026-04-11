# 🧮 Floating Point Addition (IEEE-754)

![License](https://img.shields.io/badge/License-MIT-green.svg)
![Language](https://img.shields.io/badge/Verilog-RTL-blue.svg)
![Standard](https://img.shields.io/badge/IEEE-754-critical.svg)
![Linted](https://img.shields.io/badge/Linted-Verible-yellow.svg)
![Formatted](https://img.shields.io/badge/Formatted-Verible-violet.svg)
![Simulation](https://img.shields.io/badge/Simulation-Passed-success.svg)

---

## 📌 Overview

This project implements a **32-bit IEEE-754 Floating Point Addition Unit** in Verilog.  
The design follows a **Finite State Machine (FSM)** based approach to perform floating-point addition.

---

## ⚙️ Features

- IEEE-754 single precision (32-bit)
- FSM-based architecture
- Handles exponent, alignment, and exponent addition
- Normalization and rounding
- Overflow / Underflow detection
- Linted & formatted using Verible
- Simulated and passed so many test cases

---

## 🏗️ Project Structure

```
.
├── docs/
│   ├── floating_point_numbers.md
│   └── floating_point_addition.md
├── rtl/
│   ├── fp_addition.v
│   └── tb_fp_addition.v
├── sim/
│   ├── testcase.md
│   ├── output.txt
│   ├── dump.vcd
│   └── waveform.png
├── README.md
└── LICENSE
```
---
## 📚 Documentation

Detailed explanations of floating-point representation and addition algorithm are provided:

- 📘 [Floating Point Numbers](docs/floating_point_numbers.md) – IEEE-754 format, representation
- 📗 [Floating Point Addition](docs/floating_point_addition.md) – step-by-step addition algorithm

---

## 🧪 Testcases
All major IEEE 754 scenarios are verified including:
- Zero addition
- Positive + Positive 
- Negative + Negative 
- Positive + Negative
- Large number addition
- Overflow conditions

Detailed results: [View Testcases](sim/testcase.md)
---

## 🧹 Linting & Formatting

This project uses **Verible** for linting and formatting Verilog code.

This project follows industry-style RTL coding practices with automated linting and formatting.  
Code quality is verified before simulation to ensure clean and maintainable design.

### 🔍 Linting
```bash
verible-verilog-lint fp_addition.v
verible-verilog-lint tb_fp_addition.v
verible-verilog-format fp_addition.v
verible-verilog-format --replace fp_addition.v // To remove unwanted spaces
verible-verilog-format tb_fp_addition.v
verible-verilog-format --replace tb_fp_addition.v // To remove unwanted spaces
```
---

## 📊 Simulation Waveform

The waveform demonstrates correct FSM transitions and IEEE-754 floating-point addition behavior including alignment, normalization, and exception handling.

![Waveform](sim/waveform.png)

---

## Synthesis & Backend

Synthesis and backend are in progress

## 📄 License

This project is licensed under the MIT License.

© 2026 Asim Khan (asim-asic)
