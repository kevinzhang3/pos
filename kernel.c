#include <stddef.h>
#include <stdint.h>

// vga default buf addr (from ibm)
volatile uint16_t* vga_buf = (uint16_t*)0xB8000;

const int VGA_COLS = 80;
const int VGA_ROWS = 25;

int term_col = 0;
int term_row = 0;
uint8_t term_color = 0x0F // binary 00001111 (black back, white fore)
                          // VGA buf takes:
                          // 4 bits background
                          // 4 bits foreground
                          // 8 bits ASCII char 

