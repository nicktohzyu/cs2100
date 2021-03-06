# sample3.asm
.data 0x10000100
       t2: .word 1, 2, 3, 4

       .text
       #set up $20 to contain base address array 0x10000100
       lui $20, 0x1000
       ori $20, $20, 0x0100
       #set up $21 to contain size of array
       ori $21, $zero, 0x0004

	addi $8, $0, 0		# use $t0 as counter because $1 is reserved
	add $3, $20, $8             # $3 stores the address of the current word
loop: 	lw $4, 0($3)			# loads arr[i] into $4
	srl $5, $4, 16 
       sll $6, $4, 16 
       or $4, $5, $6
	sw $4, 0($3)			# writes updated value to arr[i]
	addi $8, $8, 1			# increment counter
	addi $3, $3, 4		# update address of arr[i]
	slt $5, $8, $21 		
       bne $5, $zero, loop		# loops if $t3<$t21 ie i < array size

# main:  li $v0, 4
#        la $a0, msg
#        syscall
#        lb $t0, 4($a0)       # load 'o' into $t0
#        addi $t0, 0xFFFFFFE0 # change $t0 to ASCII value of 'O'
#        sb $t0, 4($a0)       # store $t0 into the memory location of 'o'
#        syscall              # perform another syscall
#        li $v0, 10
#        syscall
