.data 0x10010000
       A: .word 3, -1, 7, 0, 2, -5, 9, 0, -9, 1
.data 0x10010100
       B: .word 2, 5, 7, 3, 6, 0, 8, 0, -3, 2

.text 
    li $s0, 0x10010000
    li $s1, 0x10010100

add $s2, $s0, $zero #inst 1
add $s3, $s1, $zero #inst 2
L1: lw $t0, 0($s2) #inst 3
lw $t1, 0($s3) #inst 4
bne $t0, $zero, L2 #inst 5
beq $t1, $zero, done #inst 6
L2: slt $t2, $t0, $t1 #inst 7
beq $t2, $zero, L3 #inst 8
sw $t0, 0($s3) #inst 9
sw $t1, 0($s2) #inst 10
L3: addi $s2, $s2, 4 #inst 11
addi $s3, $s3, 4 #inst 12
j L1 #inst 13
done: