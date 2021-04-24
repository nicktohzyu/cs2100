# arrayCount.asm
  .data 
arrayA: .word 11, 0, 31, 20, 9, 17, 6, 9  # arrayA has 8 values
count:  .word 0                           # dummy value

  .text
main:
        # code to setup the variable mappings
        la  $t0, arrayA        # map address of arrayA to $t0
        la  $t8, count         # map address of count to $t8

        # code to read in array values
        add $t1, $t0, $zero    # copy base address
        addi $t2, $t0, 32    # upper bound
rLoop:  beq $t1, $t2, cont
        li   $v0, 5            # system call code for read_int
        syscall
        sw $v0, 0($t1)
        addi $t1, $t1, 4
        j rLoop

        # code for reading in the user value X
cont:   li   $v0, 5            # system call code for read_int
        syscall              # read the integer into $v0
        add $t2, $zero, $v0  # save the read integer to $t2
        addi $t2, $t2, -1

        # code for counting multiples of X in arrayA
        lw  $t1, 0($t8)      # intialize count reg
        addi $t3, $t0, 32     # upper bound of i
loop:   beq $t0, $t3, exit   # if reach upper bound, exit
        lw $t4, 0($t0)       # load the value of array element
        and $t5, $t4, $t2    # take modulo
        bne $t5, $zero, skip # if have remainer, skip
        addi $t1, $t1, 1     # increment count
skip:   addi $t0, $t0, 4     # increment i
        j loop

        # code for printing result
exit:   li   $v0, 1          # system call code for print_int
        add  $a0, $zero, $t1 # integer to print
        syscall              # print the integer
        sw $t1, 0($t8)

        # code for terminating program
        li  $v0, 10
        syscall
