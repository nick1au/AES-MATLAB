# AES-MATLAB
A AES-Inspired Cryptography Program using MATLAB with character-based matrix manipulation.

## About
* Course-based Project - VCC SCIE 1180 (Introduction to Engineering Analysis)
* Active in August 2016
* Individual Project
* Professor: Pooya Taheri

## Project Info
* AES-inspired ASCII-based text encryption and decryption ([source](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard))
* MATLAB-based
* Converts text to a matrix table and vise-versa.
* GUI created using GUIDE
* All steps broken down into separate .m files

## Project Breakdown

### Encrypt/Decrypt
* Provides the steps to complete encryption/decryption
* Requires a minimum key length of four characters, at least one repetition to perform mix_col, add_key_to_data and shift_row and some data.
* Performs the following steps:  

1. Convert user data into ASCII of int64.
2. Generate Key
3. Convert data to square matrix and an ASCII integer.
4. Add the key to the data.
5. Repeats the following in repetition  
i. Shift the row  
ii. Creates an array based on the column and multiplies them.  
iii. Add the key to the data.  
6. Shift the row a last time
7. Add the key to the data a last time.

* For the decrypt, steps 3-6 are performed in reverse order.

### Gen_key
* Creates a key by converting the user password key into an int16 array. This is then transposed and multiplied together, then rounded.
* Output is an int.

### Add_key_to_data
* Adds the key to all elements of the user data.

### Convert_sq
* Converts the text data to be encrypted as a square.
* If the data cannot be directly converted, then filler data is put in to achieve an appropriate size.

### Mix_col
* Creates a polynomial key using the crypto key by using the remainders/ the digits from right to left as the poly key.
* Polykey is multiplied to each column
* This array key is multiplied into columns of data

### Shift_row/Rev_shift_row
* Moves the elements to the left by m-1, where m is the position on the matrix
