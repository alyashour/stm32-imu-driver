# STM32 IMU Driver

This project is an STM32 driver written from scratch.

I wanted to learn as much as possible about microcontrollers and so didn't want to use premade configs, linker scripts, headers, or anything else of the kind.

The only tools I used are the arm build tools (gcc, objcopy) and openocd for flashing & debugging. Everything else is from scratch.

## Building & Flashing

You'll need:
- arm-none-eabi buildtools (at minimum gcc and objcopy but preferably also objdump and readelf)
- openocd to flash the microcontroller

Then run:
```bash
make all        # build
make flash      # flash
```

## Hardware

To recreate this project you'll need:
- STM32103F blue pill           - Microcontroller
- ST-LINKv2                     - STM32 programmer
- MPU-6050                      - IMU & temp sensor
- Elegoo 0.96 Inch OLED Display - Output Display

For details on hardware setup see `docs/1-hardware-setup-and-connections.md`
