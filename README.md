# Floating Point Addition

![License](https://img.shields.io/badge/License-MIT-green.svg)
![Language](https://img.shields.io/badge/Verilog-RTL-blue.svg)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow.svg)
![Repo Size](https://img.shields.io/github/repo-size/asim-asic/Floating-Point-Addition)


To perform floating point addition, consider two floating point numbers will be added to form a floating point sum.
`(F1 * 2^E1) + (F2 * 2^E2) = F * 2^E`

Numbers to be added are properly normalized. In order to add two fractions, associated exponents are equal. Thus if exponents E1 and E2 are different, we must have to unnormalize one of the functions and adjust the exponent accordingly. The smaller number is one that should be adjusted so that if signifies digits are lost, effect is not significant.

**Example**

To illustrate the process, i am adding `F1 * 2^E1 = 0.111 * 2^5` and `F2 * 2^E2 = 0.101 * 2^3`

Since E2 is not equal to E1, we unnormalize the smaller number F2 by shifting right two times, and adding 2 to the exponent
`0.101 * 2^3 = 0.0101 * 2^4 = 0.00101 * 2^5`

***Note that*** shifting right one place is equivalent to dividing by 2, so each time i have to shifti have added 1 to the exponent to compensate. When the exponents are equal, add the fractions
`(0.111 * 2^5) + (0.00101 * 2^5) = 01.00001 * 2^5`

This addition caused an ***overflow*** into the sign bit position, so i have to shift right and add 1 to the exponent to correct the fraction ***overflow***. The final result is
`F * 2^E = 0.100001 * 2^6


When one of the fractions is negative, the result of adding fractions may be unnormalized, as illustrated in the following example:
(1.100 * 2^(-2)) + (0.100 * 2^(-1))
= (1.110 * 2^(-1)) + (0.100 * 2^(-1)) (after shifting F1)
= 0.010 * 2^(-1) (result of adding fractions is unnormalized)
= 0.100 * 2^(-2) (normalized by shifting left and subtracting 1 from exponent)	


**In summary**, the steps required to carry out floating-point addition are as follows:
1. Compare exponents. If the exponents are not equal, shift the fraction with the smaller exponent right and add 1 to its exponent; repeat until the exponents are equal.
2. Add the fractions (significands).
3. If the result is 0, set the exponent to the appropriate representation for 0 and exit.
4. If fraction overflow occurs, shift right and add 1 to the exponent to correct the overflow.
5. If the fraction is unnormalized, shift left and subtract 1 from the exponent until the fraction is normalized.
6. Check for exponent overflow. Set overflow indicator, if necessary.
7. Round to the appropriate number of bits. Is it still normalized? If not, go backto step 4.

---


```mermaid
flowchart TD

A[Start] --> B[Compare Exponents]

B --> C{Exponents equal?}

C -- No --> D[Shift smaller fraction right<\nIncrement exponent]
D --> B

C -- Yes --> E[Add Fractions]

E --> F{Result = 0?}

F -- Yes --> G[Set exponent appropriately]
G --> Z[Done]

F -- No --> H{Fraction overflow?}

H -- Yes --> I[Shift right\nIncrement exponent]
I --> J{Fraction normalized?}

H -- No --> J

J -- No --> K[Shift left\nDecrement exponent]
K --> J

J -- Yes --> L{Exponent overflow/underflow?}

L -- Yes --> M[Indicate overflow/underflow]
M --> X[Exception]

L -- No --> N[Round fraction to required bits]

N --> O{Still normalized?}

O -- No --> K
O -- Yes --> Z[Done]

---
