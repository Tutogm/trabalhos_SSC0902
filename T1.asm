#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Trabalho 1 Organização e Arquitetura de Computadores SSC0902
#	Alunos:					NUSP:
#	Arthur Gomes Mesquita de Souza		14835157
#	Nicolas Zimmer Fernandes		14600951
#	Luana Fialho Franco de Melo		14755061
#	Lucas Moro Farias			--------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		.data
		.align 0
text_ini:	.asciz "Boas vindas, aventureiro!\n"
menu:		.asciz "\nEscolha uma instrução do menu.\n1-Adicionar item\n2-Remover item\n3-Listar inventário\n4-Buscar item\n5- Sair\n\n=> "
text_add:	.asciz "\nForneça o ID do item para adicioná-lo:\n[ID] "

		.text
		.align 2
		.globl main
main:
		# Print boas vindas
		addi a7, x0, 4
		la a0, text_ini
		ecall

loop_escolha:
		# Print menu
		addi a7, x0, 4
		la a0, menu
		ecall

		jal get_int

		# Verificar opção
		addi t0, x0, 5
		beq a0, t0, fim_programa  

		addi t0, x0, 1
		beq a0, t0, adicionar_item

		addi t0, x0, 2
		beq a0, t0, remover_item

		addi t0, x0, 3
		beq a0, t0, lista_invent

		addi t0, x0, 4
		beq a0, t0, busca

fim_programa:
		# Encerrar programa
		addi a7, x0, 10
		ecall

adicionar_item:	 
		addi a7, x0, 4
		la a0, text_add
		ecall
		
		jal get_int
		
		j loop_escolha

remover_item:
		j loop_escolha

lista_invent:
		j loop_escolha

busca:
		j loop_escolha

get_int:
		# Função para ler inteiro do usuário
		addi a7, zero, 5
		ecall
		
		jr ra