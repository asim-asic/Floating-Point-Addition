# Floating Point Numbers Representation
A simple representation of a floating-point (or real) number (N) uses a fraction (F), base (B), and exponent (E), where `N = F * B^E`. The base can be 2, 10, 16, or any other integer larger than 1. The fraction and the exponent can be represented in many formats. 

**For example**, they can be represented by 2’s complement formats, sign-magnitude form, or another negative number representation.

## Floating Point Format using 2's complement
In this format, negative exponent and fractions are represented using 2's complement.

The base is 2, so the number is expreesed as:
`N = F * 2^E`

This allows represenation of both positive and negative values efficiently.

2's compliment is not used in standard floating point representation instead used IEEE 754 Floating Point Formats.

## IEEE 754 Floating-Point Formats
IEEE uses sign-magnitude for fraction and biased exponent and designed for easier comparision and sorting of numbers.
 
It contains two representations for floating point numbers:
- IEEE single precision format -> uses 32 bits
- IEEE double precision format -> uses 64 bits

IEEE 754 floating point formats need three sub-fields: sign, fraction, and exponent.
- There is an explicit sign bit (S) for the fraction. The sign is 0 for positive numbers and 1 for negative numbers.

In general, the number is of the form 
`N = (-1)^S * (1 + F) * 2^E`
where,
	S = sign bit,
	F = fractional part,
	E = exponent
1. The base of exponent is 2. Base is implied that is, it is not stored anywhere in representation.
2. Magnitude of number is 1 + F because of ommitted leading 1.
3. Exponent uses what is known as a **biased notation**. A **biased** representation is one in which every number is represented by number plus a certain bias.
- In the IEEE single precision format, the bias is 127.
- In the IEEE double precision format, the bias is 1023.

**Example**
 
If the exponent is +1, it will be represented by +1 + 127 = 128.
If the exponent is -2, it will be represented by -2 + 127 = 125.

Thus, exponents less than 127 indicate actual negative exponents, and exponents greater than 127 indicate actual positive exponents.

---
If a positive exponent becomes too large to fit in the exponent field, the situation is called **overflow**, and if a negative exponent is too large to fit in the exponent field, that situation is called **underflow**.


### IEEE Single Precision Format
IEEE single point precision format uses 32 bits for representing a floating-point number, divided into three subfields:
The first field is sign bit for fraction part. The next field consist of 8 bits, which are used for exponent. The third field consist of remaining 23 bits and used for fractional part.

| Field    | Bits   |
|----------|--------|
| Sign     | 1 bit  |
| Exponent | 8 bits |
| Fraction | 23 bits|

***Example***


Represent **13.45** in IEEE 754 single precision format.

---

#### Step 1: Convert to Binary

##### Integer part:
13 → `1101`

##### Fraction part (IMPORTANT):

We convert **0.45 to binary** using repeated multiplication by 2:

0.45 × 2 = 0.90 → 0  
0.90 × 2 = 1.80 → 1  
0.80 × 2 = 1.60 → 1  
0.60 × 2 = 1.20 → 1  
0.20 × 2 = 0.40 → 0  
0.40 × 2 = 0.80 → 0  
0.80 × 2 = 1.60 → 1  
0.60 × 2 = 1.20 → 1  

Collecting integer parts: `0.011100110011...`

Pattern repeats: **1100 1100...**

So, 13.45 = `1101.011100110011...`

---

#### Step 2: Normalize

Move decimal to get form `1.x × 2^E`

`1101.011100... = 1.1010111001100... × 2^3`

- Mantissa = `1.1010111001100...`
- Exponent = `3`

---

####  Step 3: Biasing

IEEE 754 bias = **127**

Stored exponent = `3 + 127 = 130`

Binary: `130 = 10000010`

---

#### Step 4: Fraction (23 bits)

Drop leading 1: `10101110011001100110011`

---

#### Step 5: Final 32-bit Representation

Sign | Exponent | Fraction  
0 | 10000010 | 10101110011001100110011  

Combined: `01000001010101110011001100110011`

---

####  Step 6: Convert to Hex

Group into 4 bits:

`0100 0001 0101 0111 0011 0011 0011 0011`

Hex: `4157 3333`

---

### ! Negative Number (-13.45)

Only sign bit changes:

`11000001010101110011001100110011`

 Hex: `C157 3333`

---

### Key Concepts

- Fraction → multiply by 2 method
- Normalization → `1.x × 2^E`
- Biasing → `E + 127`
- Fraction → drop leading 1
- Hex → group 4 bits
-----
