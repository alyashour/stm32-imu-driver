/* 
 * Define the memory regions
 * See memmap stm32f10 datasheet p. 34
 */
MEMORY {
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 64K
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

_estack = ORIGIN(SRAM) + LENGTH(SRAM);

SECTIONS 
{
    .text 
a:
    {
        /* VECTOR TABLE MUST BE FIRST. Putting it first means it lands right at 0x08000000 */
        /* KEEP tells the linker to keep this in even if no symbols are referenced which is the case for vector table */
        KEEP(*(.isr_vector))         *(.text*)
        /* we'll also include rodata here */
        *(.rodata*) /* * after the section name means include all .rodata.blahblah sections as well */
    } > FLASH /* Write it to flash */

    .data :
    {
        /* THIS WHOLE BLOCK IS IN SRAM */
        _sdata = .; /* start of data section (in SRAM) */
        *(.data*)
        _edata = .; /* end of data section in SRAM */
    } > SRAM AT > FLASH /* AT > FLASH means put it in flash but > SRAM means run from SRAM. */

    /* start of where the initial .data section is. this is in FLASH */
    /* this line can technically be anywhere in the file since section declarations are done first in a first pass???? */
    _sidata = LOADADDR(.data); 

    .bss :
    {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > SRAM
}