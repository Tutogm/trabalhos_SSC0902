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
text_ini:   .asciz "Boas vindas, aventureiro!\n"
menu:       .asciz "\nEscolha uma instrução do menu.\n1-Adicionar item\n2-Remover item\n3-Listar inventário\n4-Buscar item\n5- Sair\n\n=> "
text_add:   .asciz "\nForneça o ID do item para adicioná-lo:\n[ID] "

        .align 2
root_lista: .space 8

        .text
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

        j loop_escolha

fim_programa:
        # Encerrar programa
        addi a7, x0, 10
        ecall

adicionar_item:
        # Print texto
        addi a7, x0, 4
        la a0, text_add
        ecall

        jal get_int

        # Salva ID no SP
        addi sp, sp, -4
        sw a0, sp

        jal add_lista

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

add_lista:
        # Verifica se a lista está vazia
        la s0, root_lista
        lw t0, 0(s0)
        beqz t0, add_primeiro

        # Percorre a lista para encontrar o primeiro nó nulo
        jal percorre_lista

        jr ra

add_primeiro:
        # Alocar memória para o nó (8 bytes)
        li a0, 8          # tamanho do nó
        li a7, 9          # syscall sbrk
        ecall
        mv t1, a0         # endereço do nó alocado

        # Inicializar o nó
        sw x0, 0(t1)      # próximo = NULL
        lw t2, 0(sp)      # pegar ID do stack
        addi sp, sp, 4
        sw t2, 4(t1)      # salvar ID no nó

        # Atualizar root_lista
        la s0, root_lista
        sw t1, 0(s0)      # root->next = t1
        sw t2, 4(s0)      # root->ID = ID

        jr ra

percorre_lista:
loop_lista:
