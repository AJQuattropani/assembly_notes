%ifndef __READINT_H
%define __READINT_H

%include "io.asm"
%include "putint.asm"

%macro readchar 0
  push rbp ;prefix
  mov rbp, rsp
  sub rsp, 1

  read rbp, 1
  write rbp, 1

  mov rsp, rbp
  pop rbp
%endmacro

; returns rax, value stored in memory
%macro readint_hex 0
  push rbp
  mov rbp, rsp
  sub rsp, BUFF_HX_UINT
  call _readint_hex

  mov rsp, rbp
  pop rbp
%endmacro

section .text
_readint_hex:
  ;read rbp, BUFF_HX_UINT
  ;write rbp, BUFF_HX_UINT

  ;xor rax, rax ; set accum to 0
  
  ret

%endif
