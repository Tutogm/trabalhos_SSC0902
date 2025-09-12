#Bubblesort

        .data
        .align 2
num:    .word 7, 5, 2, 1, 1, 3, 4   # Vetor
N:      .word 7                     # Tamanho do vetor

        .text
        .align 2
        .globl main
main:
        # base do vetor em s0
        la      s0, num

        # N em s1
        la      t2, N
        lw      s1, 0(t2)

        # chama bubble sort
        jal     ra, bubblesort

# =========================
# Print do vetor final
# =========================
        addi    t0, zero, 0          # i = 0
print_loop:
        bge     t0, s1, print_end    # if (i >= N) fim do print

        slli    t1, t0, 2            # offset = i*4
        add     t2, s0, t1
        lw      a0, 0(t2)            # a0 = num[i]

        addi    a7, zero, 1          # print_int
        ecall

        addi    a7, zero, 11         # print_char
        li      a0, 32               # ' '
        ecall

        addi    t0, t0, 1            # i++
        j       print_loop

print_end:
        addi    a7, zero, 11         # '\n'
        li      a0, 10
        ecall

exit:
        addi    a7, zero, 10         # exit
        ecall


# ====================================
# bubblesort(s0 = base, s1 = N)
# ====================================
bubblesort:
        addi    t0, zero, 0          # i = 0
loop_i:
        addi    t2, s1, -1
        bge     t0, t2, end_sort     # if (i >= N-1) fim

        addi    t1, zero, 0          # j = 0
loop_j:
        sub     t3, s1, t0           # t3 = N - i
        addi    t3, t3, -1           # t3 = N - i - 1
        bge     t1, t3, end_loop_j   # if (j >= N-1-i) fim do j

        # --------- num[j] ----------
        slli    t2, t1, 2            # t2 = j*4
        add     t6, s0, t2           # t6 = &num[j]
        lw      t4, 0(t6)            # t4 = num[j]

        # -------- num[j+1] ---------
        addi    t2, t1, 1            # t2 = j+1
        slli    t2, t2, 2            # t2 = (j+1)*4
        add     t2, s0, t2           # t2 = &num[j+1]
        lw      t5, 0(t2)            # t5 = num[j+1]

        # if (num[j] > num[j+1]) swap
        ble     t4, t5, no_swap

        sw      t5, 0(t6)            # num[j]   = antigo num[j+1]
        sw      t4, 0(t2)            # num[j+1] = antigo num[j]

no_swap:
        addi    t1, t1, 1            # j++
        j       loop_j

end_loop_j:
        addi    t0, t0, 1            # i++
        j       loop_i

end_sort:
        jr      ra
