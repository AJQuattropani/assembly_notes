#! /usr/bin/bash

yasm -o ./build/main.o -f elf64 ./main.asm
yasm -o ./build/io.o -f elf64 ./io.asm
yasm -o ./build/putint.o -f elf64 ./putint.asm
yasm -o ./build/readint.o -f elf64 ./putint.asm
ld -o ./build/main ./build/main.o ./build/putint.o ./build/io.o
