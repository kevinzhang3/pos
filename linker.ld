ENTRY(start)

SECTIONS
{
    . = 1M;

    /* multiboot header for grub */
    .rodata BLOCK(4K) : ALIGN(4K)
    {
        *(.multiboot)
    }

    /* executable code section */
    .text BLOCK(4K) : ALIGN(4K)
    {
        *(.text)
    }

    /* read only data */
    .rotdata BLOCK(4K) : ALIGN(4K)
    {
        *(.rodata)
    }
    /* RW data initialized */
    .data BLOCK(4K) : ALIGN(4K)
    {
        *(.data)
    }
    /* RW data uninitialized and stack */
    .bss BLOCK(4K) : ALIGN(4K)
    {
        *(COMMON)
        *(.bss)
    }
}
