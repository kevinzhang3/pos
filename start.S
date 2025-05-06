// main in kernel.c
.extern kernel_main

// for linker script 
.global start

// magic number for GRUB
.set MB_MAGIC, 0x1BADB002 
