#strcpy:

		.data
		.align 0
str_src:	.asciz	"Frase"
str_dst:	.space	30

		.text
		.align 2
		.globl main
		
main:		
		#Armazena os endereços das strings
		la a0, str_src
		la a1, str_dst
		
		#Branch para função strcpy
		jal strcpy
		
		#Print str_dst
		addi a7, zero, 4
		la a0, str_dst
		ecall

exit:		
		#Sai do programa
		addi a7, zero, 10
		ecall
		
strcpy:		
strcpy_loop:	
		#Salvando str_src em str_dst
		lb t0, 0(a0)
		sb t0, 0(a1)
		
		#Incrementando o byte
		addi a0, a0, 1
		addi a1, a1, 1
		
		#Caso t0 != \0, voltamos para o começo do loop
		#Caso t0 = \0, saímos do loop e voltamos para a main
		bnez t0, strcpy_loop
		jr ra
