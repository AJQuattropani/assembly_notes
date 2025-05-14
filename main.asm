section .text
  global _start
_start:
_exit:
  push 0x3c ; exit code 60, exit
  pop rax
  xor rdi, rdi
  syscall
section .data
section .bss
section .rodata
