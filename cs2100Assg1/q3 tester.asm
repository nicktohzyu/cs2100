# sample3.asm
.data 0x10000100
       t2: .word 0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 0, 2, 0, 0, 1, 0, 0, 2, 
.data 0x10000200
       result: .word 0, 0, 0 
# msg:   .asciiz "Hello"
       .text
       #set up $s0 to contain base address of t2 0x10000100
       lui $s0, 0x1000
       ori $s0, $s0, 0x0100
       #set up $s1 to contain address of result
       lui $s1, 0x1000
       ori $s1, $s1, 0x0200

# copy your code here to test
