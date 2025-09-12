#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Trabalho 1 Organização e Arquitetura de Computadores SSC0902
#	Alunos:					NUSP:
#	Arthur Gomes Mesquita de Souza		14835157
#	Nicolas Zimmer Fernandes		--------
#	Luana Fialho Franco de Melo		14755061
#	Lucas Moro Farias			--------
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

              .data
              .align 0
text_ini:     .asciz "Boas vindas, aventureiro!\n"
menu:         .asciz "Escolha uma instrução do menu.\n1-Adicionar item\n2-Remover item\n3-Listar inventário\n4-Buscar item\n5- Sair\n\n=>"

              .text
              .align 2
              .globl main
main:        
              #printar boas vindas
              addi a7, x0, 4
              la a0, text_ini
              ecall
              j loop_escolha
loop_escolha:
              #printar tabela
              addi a7, x0, 4
              la a0, menu
              ecall
              addi a7, x0, 5
              ecall
              addi t0, x0, 5
              beq a0, t0, fim_programa  
              addi t0, x0, 1
              beq a0, t0, adicionar_item
              addi t0, x0, 2
              beq a0, t0, remover_item
              addi t0, x0, 3
              beq a0, x0, lista_invent
              addi t0, x0, 4
              beq a0, x0, busca

fim_programa:
            addi a7, x0, 10
            ecall
adicionar_item:
             j loop_escolha
remover_item:
            j loop_escolha
lista_invent:
            j loop_escolha
busca:
            j loop_escolha
