# sample3.asm
.data 0x10000100
       t2: .word 1, 2, 3, 4

       .text
       #set up $20 to contain base address array 0x10000100
       lui $20, 0x1000
       ori $20, $20, 0x0100
       #set up $21 to contain size of array
       ori $21, $zero, 0x0004

# copy your code here to test