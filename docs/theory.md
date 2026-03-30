# Floating Point Numbers Representation
A simple representation of a floating-point (or real) number (N) uses a fraction (F), base (B), and exponent (E), where `N = F * B^E`. The base can be 2, 10, 16, or any other integer larger than 1. The fraction and the exponent can be represented in many formats. 

**For example**, they can be represented by 2’s complement formats, sign-magnitude form, or another negative number representation.

## Floating Point Format using 2's complement
In this format, negative exponent and fractions are represented using 2's complement.

The base is 2, so the number is expreesed as:
`N = F * 2^E`

This allows represenation of both positive and negative values efficiently.

