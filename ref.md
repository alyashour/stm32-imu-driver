# Reference

## Building

```bash
arm-none-eabi-gcc -c startup.s -o out/startup.o
arm-none-eabi-gcc -c main.s    -o out/main.o 
arm-none-eabi-gcc -T linker.ld -nostdlib out/startup.o out/main.o -o out/main.elf

arm-none-eabi-objcopy -O binary out/main.elf out/main.bin
```

## Looking into build

```bash
arm-none-eabi-objdump -d out/main.elf   # see disassembly
arm-none-eabi-readelf -S out/main.elf   # see sections and their addresses
xxd out/main.bin                        # read output bin
```

It's in little endian but you should be able to see the stack pointer and addr for Reset_Handler