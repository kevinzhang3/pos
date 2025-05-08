// main in kernel.c
.extern kernel_main

// for linker script 
.global start

.set MB_MAGIC, 0x1BADB002 // set magic number for GRUB (bro wtf does ts do)
.set MB_FLAGS, (1 << 0 ) | (1 << 1) 
.set MB_CHECKSUM, (0 - (MB_MAGIC + MB_FLAGS)) // checksum

.section .multiboot
    .align 4
    .long MB_MAGIC
    .long MB_FLAGS
    .long MB_CHECKSUM

.section .bss
    .align 16
    stack_bottom:
        .skip 4096
    stack_top:

.section .text
    start:
        mov $stack_top, %esp // place ts at top of stack
        call kernel_main
        hang: // should not reach
            cli
            hlt
            jmp hang
