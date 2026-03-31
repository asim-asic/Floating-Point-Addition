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
    
