#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Trabalho 1 Organização e Arquitetura de Computadores SSC0902
# Alunos:                        NUSP:
# Arthur Gomes Mesquita de Souza 14835157
# Nicolas Zimmer Fernandes       14600951
# Luana Fialho Franco de Melo    14755061
# Lucas Moro Farias              --------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	        .data
	        .align 0
text_ini:   	.asciz "Boas vindas, aventureiro!\n"
menu:       	.asciz "\nEscolha uma instrução do menu.\n1-Adicionar item\n2-Remover item\n3-Listar inventário\n4-Buscar item\n5- Sair\n\n=> "
text_add:   	.asciz "\nForneça o ID do item para adicioná-lo:\n[ID] "
	
        	.align 2
root_lista: 	.space 4      # ponteiro para o primeiro nó (NULL inicialmente)

	        .text
	        .globl main
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
		
	        j loop_escolha

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fim_programa:
	        # Encerrar programa
	        addi a7, x0, 10
	        ecall

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

remover_item:
        	j loop_escolha

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

lista_invent:
	        # carrega o início da lista
	        la t0, root_lista
	        lw t1, 0(t0)         # t1 = primeiro nó
	        beqz t1, fim_lista_inv   # se lista vazia, sai

loop_inv:
	        lw a0, 4(t1)         # carrega ID
	        li a7, 1             # syscall print_int
	        ecall
	
	        # print espaço depois do número
	        li a7, 11            # syscall print_char
	        li a0, 32            # espaço em ASCII
	        ecall
	
	        lw t1, 0(t1)         # avança para próximo nó
	        bnez t1, loop_inv    # continua se não for NULL

fim_lista_inv:
	        # print quebra de linha
	        li a7, 11
	        li a0, 10            # '\n'
	        ecall
	        jr ra
	        
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
busca:
        	j loop_escolha
        	
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

get_int:
	        # Função para ler inteiro do usuário
	        addi a7, zero, 5
	        ecall
	        jr ra
	        
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
adicionar_item:
	        # Print texto
	        addi a7, x0, 4
	        la a0, text_add
	        ecall
		
	        jal get_int
		
	        # Salva ID no SP
	        addi sp, sp, -4
	        sw a0, 0(sp)
		
	        jal add_lista
		
	        j loop_escolha
	        
add_lista:
	        # Verifica se a lista está vazia
	        la s0, root_lista
	        lw t0, 0(s0)
	        beqz t0, add_primeiro
		
	        # Percorre a lista para encontrar o último nó
	        jal percorre_lista
		
	        jr ra
	
add_primeiro:
	        # Alocar memória para o nó (8 bytes)
	        li a0, 8           # tamanho do nó
	        li a7, 9           # syscall sbrk
	        ecall
	        mv t1, a0          # endereço do nó alocado
		
	        # Inicializar o nó
	        sw x0, 0(t1)       # próximo = NULL
	        lw t2, 0(sp)       # pegar ID do stack
	        addi sp, sp, 4
	        sw t2, 4(t1)       # salvar ID no nó
		
	        # Atualizar root_lista para apontar para o nó criado
	        la s0, root_lista
	        sw t1, 0(s0)
		
	        jr ra

percorre_lista:
	        # carrega o início da lista
	        la t0, root_lista
	        lw t1, 0(t0)       # t1 = ponteiro para primeiro nó
	
loop_lista:
	        lw t2, 0(t1)       # t2 = próximo nó
	        beqz t2, fim_lista # se próximo == NULL, achou o fim
	        mv t1, t2          # avança para o próximo
	        j loop_lista
	
fim_lista:
		# alocar memória para o novo nó
	        li a0, 8
	        li a7, 9
	        ecall
	        mv t2, a0          # endereço do novo nó
		
	        # inicializar novo nó
	        sw x0, 0(t2)       # próximo = NULL
	        lw t3, 0(sp)       # pega ID da pilha
	        addi sp, sp, 4
	        sw t3, 4(t2)
		
	        # encadear novo nó ao último
	        sw t2, 0(t1)
		
	        j loop_escolha