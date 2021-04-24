# arrayFunction.asm
       .data 
array: .word 8, 2, 1, 6, 9, 7, 3, 5, 0, 4
newl:  .asciiz "\n"

       .text
main:
	# establish mapping of array
	la  $s0, array
	
	# Print the original content of array
	# setup the parameter(s)
	add   $a0, $s0, $zero # load address of array
	addi $a1, $zero, 10   # number of array elements
	# call the printArray function
	jal printArray

	# Ask the user for two indices
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t0, $v0, 0    	# first user input in $t0
 
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t1, $v0, 0    	# second user input in $t1

	# Call the findMin function
	# setup the parameter(s)
	sll $t0, $t0, 2       # mulitply index by 4 to get byte offset
	sll $t1, $t1, 2
	add $a0, $s0, $t0     # lower pointer
	add $a1, $s0, $t1     # load higher array pointer

	# call the function
	jal findMin
	add $s1, $v0, $zero   # save address of min element to $s1

	# Print the min item
	# place the min item in $t3	for printing
	lw $t3, 0($s1)

	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
	addi $a0, $t3, 0    # print $t3
	syscall       		# make system call

	li   $v0, 4   		# system call code for print_string
	la   $a0, newl    	# 
	syscall       		# print newline

	#Calculate and print the index of min item
	# Place the min index in $t3 for printing	
	sub $t3, $s1, $s0
	srl $t3, $t3, 2

	# Print the min index
	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
	addi $a0, $t3, 0    # print $t3
	syscall       		# make system call
	
	li   $v0, 4   		# system call code for print_string
	la   $a0, newl    	# 
	syscall       		# print newline
	
	# End of main, make a syscall to "exit"
	li   $v0, 10   		# system call code for exit
	syscall	       	# terminate program
	

#######################################################################
###   Function printArray   ### 
#Input: Array Address in $a0, Number of elements in $a1
#Output: None
#Purpose: Print array elements
#Registers used: $t0, $t1, $t2, $t3
#Assumption: Array element is word size (4-byte)
printArray:
	addi $t1, $a0, 0	#$t1 is the pointer to the item
	sll  $t2, $a1, 2	#$t2 is the offset beyond the last item
	add  $t2, $a0, $t2 	#$t2 is pointing beyond the last item
l1:	
	beq  $t1, $t2, e1
	lw   $t3, 0($t1)	#$t3 is the current item
	li   $v0, 1   		# system call code for print_int
	addi $a0, $t3, 0    	# integer to print
	syscall       		# print it
	addi $t1, $t1, 4
	j l1				# Another iteration
e1:
	li   $v0, 4   		# system call code for print_string
	la   $a0, newl    	# 
	syscall       		# print newline
	jr $ra			# return from this function


#######################################################################
###   Student Function findMin   ### 
#Input: Lower Array Pointer in $a0, Higher Array Pointer in $a1
#Output: $v0 contains the address of min item 
#Purpose: Find and return the minimum item 
#              between $a0 and $a1 (inclusive)
#Registers used: <Fill in with your register usage>
#Assumption: Array element is word size (4-byte), $a0 <= $a1
findMin:
	add $v0, $a0, $zero # initialize min to address of first element
	lw  $t0, 0($v0)     # load value of first element
	add $t1, $a0, $zero # initialize iterator
	addi $t2, $a1, 4    # upper bound of iterator
l2:
	addi $t1, $t1, 4    # increment iterator
	beq $t1, $t2, e2    # if iterator reaches upper bound, exit
	lw  $t3, 0($t1)     # load array element
	slt $t4, $t3, $t0   # $t4 = $t0 < $t3
	beq $t4, $zero, l2  # continue the loop if $t0 >= $t3
	add $v0, $t1, $zero # assign new adress of min value
	add $t0, $t3, $zero # assign new min value
	j l2                # loop
e2:
	jr $ra			# return from this function
