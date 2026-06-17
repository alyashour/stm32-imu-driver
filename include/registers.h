// Pointers to mem-mapped peripheral registers
// From STM32F103 reference manual

#define RCC_APB2ENR (*(volatile unsigned int *)0x40021018)
#define GPIOC_CRH (*(volatile unsigned int *)0x40011004)
#define GPIOC_BSRR (*(volatile unsigned int *)0x40011010)