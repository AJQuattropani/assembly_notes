#! /usr/bin/bash

yasm -o ./build/main.o -f elf64 ./main.asm
ld -o ./build/main ./build/main.o
