%ifndef __IO_H
%define __IO_H

%define BUFF_HX_UINT 16 ; hex buff size
%define BUFF_BX_UINT 64 ; binary buff size

%macro write 2
  mov rax, 0x1
  mov rdi, rax
  mov rsi, %1
  mov rdx, %2
  syscall
%endmacro

%macro read 2
  mov rax, 0x0
  mov rdi, rax
  mov rsi, %1
  mov rdx, %2
  syscall
%endmacro

%endif
