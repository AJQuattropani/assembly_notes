%include "putint.asm"

%macro exit 1
  push %1
  jmp _exit
%endmacro

section .text
  global _start, _putint_hex, _exit
_exit:
  push 0x3c ; syscall 60
  pop rax
  pop rdi
  syscall
_start:
  putint_dec [NUM]
  putchar byte 0xa
  putint_hex [NUM]
  putchar byte 0xa
  putint_bin [NUM]
  exit 0
_main:
section .data
section .rodata
  NUM dq 0xfedcba9876543210 ; should match output
