.data 0x10010000
       A: .word 1, 2, 3, 4, 5, 0
.data 0x10010100
       B: .word 1, 2, 3, 4, 5, 0

.text 
    li $s0, 0x10010000
    li $s1, 0x10010100

    addi $s2, $zero, 0
    addi $t0, $s0, 0
    addi $t1, $s1, 0
    addi $t4, $zero, 0
    addi $t5, $zero, 24
    loop: beq $t4, $t5, out
    lw $t2, 0($t0)
    lw $t3, 0($t1)
    beq $t2, $zero, out
    beq $t3, $zero, out
    bne $t2, $t3, notequal
    add $s2, $s2, $t2
    notequal: addi $t4, $t4, 4
    add $t0, $s0, $t4
    add $t1, $s1, $t4
    j loop
    out: