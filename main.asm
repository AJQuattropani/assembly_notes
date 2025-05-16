%include "putint.asm"
%include "readint.asm"

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
  readchar

  putchar 0xa
  ;readint_hex
  
  putint_hex [NUM]
  putchar 0xa
  putint_bin [NUM]
  exit 0
_main:
section .data
section .rodata
  NUM dq 0xfedcba9876543210 ; should match output
