#include <stddef.h>
#include <stdint.h>

// vga default buf addr (from ibm)
volatile uint16_t* vga_buf = (uint16_t*)0xB8000;

const int VGA_COLS = 80;
const int VGA_ROWS = 25;

// globals for placing char
int term_col = 0;
int term_row = 0;
uint8_t term_color = 0x0F; // binary 00001111 (black back, white fore)
                          // VGA buf takes:
                          // 4 bits background
                          // 4 bits foreground
                          // 8 bits ASCII char

/**
 * Initialize the VGA terminal
 */
void term_init(void) {
    // clear the buffer by looping over entire buffer (COLS * ROWS)
    // we clear left to right, index calculated because each new row
    // starts at a multiple of 80 (NCOLS)
    for (int row = 0; row < VGA_ROWS; ++row) {
        for (int col = 0; col < VGA_COLS; ++col) {
            const size_t index = (VGA_COLS * row) + col;
            // shift away the color bits (upper 4) and store blank char
            // in the ASCII char bits (' ' == 32)
            vga_buf[index] = ((uint16_t)term_color << 8) | ' ';
        }
    }
}

/**
 * print char on terminal
 */
void term_putc(char c) {
    const size_t index = (VGA_COLS * term_row) + term_col; 
    if (c == '\n') {
        term_row++;
        term_col = 0;
    } else {
        // clear buf for char
        vga_buf[index] = ((uint16_t)term_color << 8) | c;
        term_col++;
        if (term_col >= VGA_COLS) {
            term_col = 0;
            term_row++;
        }
        // we need to implement scrolling but for now we just do this
        if (term_row >= VGA_ROWS) {
            term_col = 0;
            term_row = 0;
        }
    }
}

/**
 * Print an entire string
 */
void term_print(const char* str) {
    for (size_t i = 0; str[i] != '\0'; ++i) {
        term_putc(str[i]);
    }
}

/**
 * main
 */
void kernel_main(void) {
    term_init();

    term_print("ENTERED KERNEL\n");
}
