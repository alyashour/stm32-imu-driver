#include "registers.h"

#define WAIT_TIME 200000

static void delay(volatile unsigned int n) {
  while (n--);
}

int main(void) {
  RCC_APB2ENR |= (1 << 4); // enable gpioc clock

  GPIOC_CRH &= ~(0xF << 20); // clear pc13 config
  GPIOC_CRH |= (0x2 << 20);  // output, push-pull, 2MHz

  while (1) {
    GPIOC_BSRR = (1 << 13); // pin high = LED off
    delay(WAIT_TIME);
    GPIOC_BSRR = (1 << 29); // pin low = LED on
    delay(WAIT_TIME);
  }
}