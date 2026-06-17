.section .isr_vector, "a"   @ vector table
.word 0x20020000            @ stack pointer
.word main                  @ reset handler

.section .text
.global main
main:
    b main
