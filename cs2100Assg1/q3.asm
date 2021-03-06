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

       add $t0, $zero, $zero		# $t0 represents our counter i, initialized to 0
       addi $t1, $zero, 6		# $t1 holds the value 6 (to exit the loop)
       add $t2, $zero, $s0		# $t2 holds the address of t2[i]
loop: 	beq $t0, $t1, exit
 	lw $t3, 8($s1) 			# load result.num2 into $t3
 	lw $t4, 8($t2) 			# load t2[i].num2 into $t4
 	add $t3, $t3, $t4		# add t2[i].num2 to result.num2
	sw $t3, 8($s1) 		# store the updated result.num2
	addi $t0, $t0, 1		# increment i
	addi $t2, $t2, 12		# update address of t2[i] (strength reduction to avoid multiply)
	j loop
exit:

# main:  li $v0, 4
#        la $a0, msg
#        syscall
#        lb $t0, 4($a0)       # load 'o' into $t0
#        addi $t0, 0xFFFFFFE0 # change $t0 to ASCII value of 'O'
#        sb $t0, 4($a0)       # store $t0 into the memory location of 'o'
#        syscall              # perform another syscall
#        li $v0, 10
#        syscall
