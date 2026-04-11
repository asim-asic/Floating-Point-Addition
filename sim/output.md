# Floating Point Addition — IEEE 754 Single Precision (RTL Design)

A 32-bit IEEE 754 single-precision floating-point adder implemented in Verilog using a Finite State Machine (FSM).  
Simulated using **Icarus Verilog (iverilog)** on Ubuntu.

---

## 📁 Project Structure

```
├── fp.v          # RTL Design — Floating Point Adder (FSM)
├── tb_fp.v       # Testbench
└── README.md     # Project documentation
```

---

## ⚙️ How to Run

```bash
# Compile
iverilog -o fp_sim fp.v tb_fp.v

# Simulate
vvp fp_sim
```

---

## 🧪 Test Results

| Addend (Binary)         | Addend (IEEE SP) | Augend (Binary)          | Augend (IEEE SP) | Sum (Binary)            | Sum (IEEE SP) |
|-------------------------|------------------|--------------------------|------------------|-------------------------|---------------|
| 0                       | x00000000        | 0                        | x00000000        | 0                       | x00000000     |
| 1 × 2⁰                  | x3F800000        | 1 × 2⁰                   | x3F800000        | 1 × 2¹                  | x40000000     |
| −1 × 2⁰                 | xBF800000        | −1 × 2⁰                  | xBF800000        | −1 × 2¹                 | xC0000000     |
| 1 × 2⁰                  | x3F800000        | −1 × 2⁰                  | xBF800000        | 0                       | x00000000     |
| 1.111… × 2¹²⁷           | x7F7FFFFF        | 1 × 2⁰                   | x3F800000        | 1.111… × 2¹²⁷           | x7F7FFFFF     |
| −1.111… × 2¹²⁷          | xFF7FFFFF        | −1 × 2⁰                  | xBF800000        | −1.111… × 2¹²⁷          | xFF7FFFFF     |
| 1.111… × 2¹²⁷           | x7F7FFFFF        | 1.111… × 2¹²⁷            | x7F7FFFFF        | **overflow**            | —             |
| −1.111… × 2¹²⁷          | xFF7FFFFF        | −1.111… × 2¹²⁷           | xFF7FFFFF        | **overflow**            | —             |
| 1.11 × 2⁸                | x43E00000        | −1.11 × 2⁶               | xC2E00000        | 1.0101 × 2⁸             | x43A80000     |
| −1.11 × 2⁸               | xC3E00000        | 1.11 × 2⁶                | x42E00000        | −1.0101 × 2⁸            | xC3A80000     |
| 1.111… × 2¹²⁷           | x7F7FFFFF        | 0.0…01 × 2¹²⁷            | x73800000        | **overflow**            | —             |
| −1.111… × 2¹²⁷          | xFF7FFFFF        | −0.0…01 × 2¹²⁷           | xF3800000        | **overflow**            | —             |
| 1.1…10 × 2¹²⁷           | x7F7FFFFE        | 0.0…01 × 2¹²⁷            | x73800000        | 1.111… × 2¹²⁷           | x7F7FFFFF     |
| −1.1…10 × 2¹²⁷          | xFF7FFFFE        | −0.0…01 × 2¹²⁷           | xF3800000        | −1.111… × 2¹²⁷          | xFF7FFFFF     |
| 1.1 × 2⁻¹²⁶              | x00C00000        | −1.0 × 2⁻¹²⁶             | x80800000        | **underflow**           | —             |

---

## 🔧 Design Details

- **Architecture:** Mealy FSM with 7 states
- **States:** `IDLE → LOAD_B → ALIGN → ADD → NORMALIZE → CHECK → DONE`
- **Features:**
  - IEEE 754 single-precision (32-bit) addition
  - Sign-magnitude with 2's complement arithmetic
  - Exponent alignment via iterative shifting
  - Post-addition normalization
  - Overflow and underflow detection

---

## 🛠️ Tools Used

| Tool    | Purpose              |
|---------|----------------------|
| Vim     | Code Editor          |
| iverilog| Compilation          |
| vvp     | Simulation           |
| Ubuntu  | Operating System     |
