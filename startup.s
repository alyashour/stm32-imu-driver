@@@ VECTOR TABLE @@@
.section .isr_vector, "a"
    .word _estack       @ See the linker.ld for this definition. end of pointer stack
    .word Reset_Handler @ this is where the processor first jumps to

    @ setting the rest of the vector table to hang for now
    .word hang  @ NMI
    .word hang  @ HardFault
    .word hang  @ MemManage
    .word hang  @ BusFault 
    .word hang  @ UsageFault
    .word 0     @ RESERVED
    .word 0     @ RESERVED    
    .word 0     @ RESERVED    
    .word 0     @ RESERVED    
    .word hang  @ SVCall
    .word 0     @ RESERVED
    .word 0     @ RESERVED
    .word hang  @ PendSV
    .word hang  @ SysTick

@@@ TEXT SECTION @@@
.section .text

@@ Reset_Handler runs after every system reset
@@ - copies .data from FLASH to SRAM
@@ - zeroes out .bss
@@ - then calls main
.global Reset_Handler
Reset_Handler:
    @ load the start of initial data (FLASH) and the start and end of where to put it into SRAM
    ldr r0, =_sidata
    ldr r1, =_sdata
    ldr r2, =_edata

    @ copy loop
    b copy_check

@ COPY
@ Copies 4 bytes from initial .data (FLASH) to .data (SRAM)
copy_loop:
    ldr r3, [r0], #4    @ load  4bytes of what's in sidata into r3, then increment r0 by 4
    str r3, [r1], #4    @ write 4bytes of what's in r3 into sdata, then increment r1 by 4
copy_check:
    cmp r1, r2          @ compare start of data and end of data
    blt copy_loop       @ if start < end, loop
@ COPY DONE

@ ZERO .BSS
    ldr r0, =_sbss      @ load start of bss into r0
    ldr r1, =_ebss      @ load end of bss into r1
    mov r2, #0          @ fill r2 with 0
    b   bss_check
bss_loop:
    str r2, [r0], #4    @ put r2 (=#0) into r0, then increment by 4 bytes
bss_check:
    cmp r0, r1 
    blt bss_loop
@ ZERO .BSS DONE

@ Call main
    b main

@ When main is done just hang instead of going off into memory
hang:
    b hang
