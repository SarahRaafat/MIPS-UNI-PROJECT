.data

# Representation 1: Tree elements (DFS order)
rep1: .word 1, 2, 3, 4, 5, 6, 7
rep1_size: .word 7

# Representation 2: Tree elements (BFS order)
rep2: .word 1, 2, 4, 5, 3, 6, 7
rep2_size: .word 7

# Arrays for traversal
traversal_array1: .space 28   # 7 words (4 bytes each)
traversal_array2: .space 28   # 7 words (4 bytes each)
newline: .asciiz "\n" 

.text
.globl main

main:
    # Convert Representation 1 to Representation 2
    la $a0, rep1             #base address of source array
    lw $a1, rep1_size        #length of source array
    la $a2, traversal_array1 #base address of output array
    
    jal convertBFStoDFS     # procedure you want to test

   la $t0, traversal_array1 #base address of the array you want to print
   lw $t1 ,rep1_size        # length of the array you want to print
   li $t2, 0                #always zero

print_loop:

    bge  $t2, $t1, exit_print_loop  # Exit loop if index >= length
    sll  $t3, $t2, 2    # index * 4 (size of word)
    add  $t4, $t0, $t3  # Calculate address of dfs[index]
    lw   $a0, 0($t4)    # Load value from dfs[index]
    
#**************
    #move $a0, $v0   #if you are printing a search result uncomment this line and comment all other lines in this label
#**************
    li   $v0, 1         # Print integer syscall
    syscall             #never comment this line and the one before

    #Print newline
    li   $v0, 11        # Print character syscall
    li   $a0, 10        # ASCII code for newline
    syscall

    addi $t2, $t2, 1    # Increment index
    j    print_loop     # Jump back to the start of the loop

exit_print_loop:

    li   $v0, 10        # Exit program syscall
    syscall
convertBFStoDFS:
	move $v0, $a2

	li $t5, 1
	beq $a1, $t5, convert_rep1_to_rep2_1
	
	li $t5, 3
	beq $a1, $t5, convert_rep1_to_rep2_3
	
	li $t5, 7
	beq $a1, $t5, convert_rep1_to_rep2_7
	
	li $t5, 15
	beq $a1, $t5, convert_rep1_to_rep2_15
	
	
convert_rep1_to_rep2_1:
	lw $t1, 0($a0)
	sw $t1, 0($a2)
	
	jr $ra
		
convert_rep1_to_rep2_3:
	lw $t1, 0($a0)
	sw $t1, 0($a2)
	
	lw $t1, 4($a0)
	sw $t1, 4($a2)
	
	lw $t1, 8($a0)
	sw $t1, 8($a2)
	
	jr $ra
	
# Procedure to convert from Representation 1 (DFS) to Representation 2 (BFS)
convert_rep1_to_rep2_7:
    # $a0: Address of Representation 1
    # $a1: Size of Representation 1
    # $a2: Address of the array for Representation 2

    # Assuming a perfect binary tree with known indices
    lw $t1, 0($a0)  # Root
    sw $t1, 0($a2)

    lw $t1, 4($a0)  # Left child of root
    sw $t1, 4($a2)

    lw $t1, 12($a0)  # Right child of root
    sw $t1, 8($a2)

    lw $t1, 16($a0)  # Left child of left child
    sw $t1, 12($a2)
    
    lw $t1, 8($a0)  # Right child of left child
    sw $t1, 16($a2)

    lw $t1, 20($a0)  # Left child of right child
    sw $t1, 20($a2)

    lw $t1, 24($a0)  # Right child of right child
    sw $t1, 24($a2) 

    jr $ra
    
convert_rep1_to_rep2_15:
	lw $t1, 0($a0)
	sw $t1, 0($a2)
	
	lw $t1, 4($a0)
	sw $t1, 4($a2)
	
	lw $t1, 12($a0)
	sw $t1, 8($a2)
	
	lw $t1, 28($a0)
	sw $t1, 12($a2)
	
	lw $t1, 32($a0)
	sw $t1, 16($a2)
	
	lw $t1, 16($a0)
	sw $t1, 20($a2)
	
	lw $t1, 36($a0)
	sw $t1, 24($a2)
	
	lw $t1, 40($a0)
	sw $t1, 28($a2)
	
	lw $t1, 8($a0)
	sw $t1, 32($a2)
	
	lw $t1, 20($a0)
	sw $t1, 36($a2)
	
	lw $t1, 44($a0)
	sw $t1, 40($a2)
	
	lw $t1, 48($a0)
	sw $t1, 44($a2)
	
	lw $t1, 24($a0)
	sw $t1, 48($a2)
	
	lw $t1, 52($a0)
	sw $t1, 52($a2)
	
	lw $t1, 56($a0)
	sw $t1, 56($a2)
	
	jr $ra
	

# Procedure to convert from Representation 2 (BFS) to Representation 1 (DFS)
convertDFStoBFS:
        move $v0, $a2

	li $t5, 1
	beq $a1, $t5, convert_rep2_to_rep1_1
	
	li $t5, 3
	beq $a1, $t5, convert_rep2_to_rep1_3
	
	li $t5, 7
	beq $a1, $t5, convert_rep2_to_rep1_7
	
	li $t5, 15
	beq $a1, $t5, convert_rep2_to_rep1_15
	
convert_rep2_to_rep1_1:
	lw $t1, 0($a0)
	sw $t1, 0($a2)
	
	jr $ra
		
convert_rep2_to_rep1_3:
	lw $t1, 0($a0)
	sw $t1, 0($a2)
	
	lw $t1, 4($a0)
	sw $t1, 4($a2)
	
	lw $t1, 8($a0)
	sw $t1, 8($a2)
	
	jr $ra
	

	
convert_rep2_to_rep1_7:
    # $a0: Address of Representation 2
    # $a1: Size of Representation 2
    # $a2: Address of the array for Representation 1

    # Assuming a perfect binary tree with known indices
    lw $t1, 0($a0)  # Root
    sw $t1, 0($a2)

    lw $t1, 4($a0)  # Left child of root
    sw $t1, 4($a2)

    lw $t1, 16($a0)  # Left child of left child
    sw $t1, 8($a2)

    lw $t1, 8($a0)  # Right child of root
    sw $t1, 12($a2)

    lw $t1, 12($a0)  # Right child of left child
    sw $t1, 16($a2)

    lw $t1, 20($a0)  # Left child of right child
    sw $t1, 20($a2)

    lw $t1, 24($a0)  # Right child of right child
    sw $t1, 24($a2)

    jr $ra
    
convert_rep2_to_rep1_15:
	lw $t1, 0($a0)
	sw $t1, 0($a2)
	
	lw $t1, 4($a0)
	sw $t1, 4($a2)
	
	lw $t1, 8($a0)
	sw $t1, 12($a2)
	
	lw $t1, 12($a0)
	sw $t1, 28($a2)
	
	lw $t1, 16($a0)
	sw $t1, 32($a2)
	
	lw $t1, 20($a0)
	sw $t1, 16($a2)
	
	lw $t1, 24($a0)
	sw $t1, 36($a2)
	
	lw $t1, 28($a0)
	sw $t1, 40($a2)
	
	lw $t1, 32($a0)
	sw $t1, 8($a2)
	
	lw $t1, 36($a0)
	sw $t1, 20($a2)
	
	lw $t1, 40($a0)
	sw $t1, 44($a2)
	
	lw $t1, 44($a0)
	sw $t1, 48($a2)
	
	lw $t1, 48($a0)
	sw $t1, 24($a2)
	
	lw $t1, 52($a0)
	sw $t1, 52($a2)
	
	lw $t1, 56($a0)
	sw $t1, 56($a2)
	
	jr $ra

search1:
	#assuming target in a1, and counter in t0 and length in a2, base address in a0
	li $t0, 0
	j search1_loop
	
search1_loop:	
	bge $t0, $a2, exit_loop
	
	mul $t2, $t0, 4
	add $t2, $t2, $a0
	
	lw $t3, 0($t2)
	beq $t3, $a1, found_target
	
	addi $t0, $t0, 1
	j search1_loop
exit_loop:
	li $v0, -1
	jr $ra
found_target:
	add $v0, $t0, $zero
	j log
log:
	move $t4, $v0
	addi $t4, $t4, 1
	li $v0, -1
	j log_loop
log_loop:
	srl $t4, $t4, 1
	addi $v0, $v0, 1
	bne $t4, $zero, log_loop
	
	jr $ra	
	
search2:
	addi $sp, $sp, 4
 	sw $ra, 0($sp)
 	
	jal convertDFStoBFS
	
	la $a0, traversal_array2
	la $a1, 2
	la $a2, rep2_size
	
	
	jal search1
 	
 	lw $ra, 0($sp)
 	jr $ra
