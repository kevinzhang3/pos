CC = i686-elf-gcc -ffreestanding -g

SRC_DIR = src
BIN_DIR = bin
TARGET = kernel.elf

SRC = $(SRC_DIR)/kernel.c $(SRC_DIR)/start.s
OBJ = $(BIN_DIR)/kernel.o $(BIN_DIR)/start.o


.PHONY: all clean

all: $(TARGET)

clean:
	rm -rf $(BIN_DIR) $(TARGET)

$(BIN_DIR):
	mkdir -p $@

$(BIN_DIR)/%.o: $(SRC_DIR)/%.c | $(BIN_DIR)
	$(CC) -c $< -o $@

$(BIN_DIR)/%.o: $(SRC_DIR)/%.s | $(BIN_DIR)
	$(CC) -c $< -o $@

$(TARGET): $(OBJ)
	$(CC) -nostdlib -T linker.ld $^ -o $@ -lgcc
