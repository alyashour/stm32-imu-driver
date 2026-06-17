# Files
TARGET 	 = out/output.elf
BINARY	 = out/output.bin 
LDSCRIPT = linker.ld

OBJS	 = out/startup.o out/main.o

# Compiler flags
CFLAGS = -Wall -mcpu=cortex-m3 -mthumb -nostdlib -I include/

all: $(BINARY)

# Fix: Explicitly match files inside out/ to source files in root
out/%.o: src/%.s | out
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

out/%.o: src/%.c | out
	arm-none-eabi-gcc $(CFLAGS) -c $< -o $@

# Compile objs and ldscript into target
$(TARGET): $(OBJS) $(LDSCRIPT) | out
	arm-none-eabi-gcc $(CFLAGS) $(OBJS) -o $@ -T $(LDSCRIPT)

# Convert target into binary
$(BINARY): $(TARGET)
	arm-none-eabi-objcopy -O binary $< $@

# Helper Rules
out:
	mkdir -p out

clean:
	rm -rf out/

.PHONY: all clean flash
