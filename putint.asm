%ifndef __PUTINT_H
%define __PUTINT_H

%include "io.asm"

%macro putchar 1
  push rbp ; prefix
  mov rbp, rsp
  sub rsp, 1

  dec rbp
  mov [rbp], byte %1

  write rbp, 1

  mov rsp, rbp
  pop rbp
%endmacro

%macro putint_hex 1
  mov rdi, %1
  push rbp
  mov rbp, rsp
  sub rsp, BUFF_HX_UINT
  call _putint_hex

  mov rsp, rbp
  pop rbp
%endmacro

%macro putint_dec 1
  mov rdi, %1
  push rbp
  mov rbp, rsp
  sub rsp, BUFF_DX_UINT
  call _putint_dec

  mov rsp, rbp
  pop rbp
%endmacro

%macro putint_bin 1
  mov rdi, %1
  push rbp
  mov rbp, rsp
  sub rsp, BUFF_BX_UINT
  call _putint_bin

  mov rsp, rbp
  pop rbp
%endmacro

section .text
_putint_hex: ; rdi: integer
  mov rax, rdi
_pi_l1:
  shr rdi, 4 ; div by 16
  push rdi ; push divided val
  shl rdi, 4 ; mul by 16
  sub rax, rdi ; remainder
  ; convert al into an alphanumeric
  add al, byte 0x30
  cmp al, byte 0x3a ; sets sign flag if its less than 0x9
  mov dil, al
  setns al ; set al to 1 if greater than 9
  mov dl, 0x27
  mul dl ; al = 0 when less than 0, al = 31 when greater
  add al, dil
  dec rbp
  mov byte [rbp], al ; map to nums
  pop rax ; pop divided val
  mov rdi, rax
  cmp rax, 0 ; test if its 0
  jne _pi_l1 ; if its not 0 jump back
  
  write rbp, BUFF_HX_UINT

  xor rax, rax ; return 0
  ret

_putint_bin:
  mov rax, rdi
_pi_l3:
  and rdi, 1 ; rightmost bit
  add rdi, 0x30
  dec rbp
  mov [rbp], dil ; map to nums
  shr rax, 1
  mov rdi, rax
  dec rsi
  cmp rax, 0
  jne _pi_l3

  write rbp, BUFF_BX_UINT

  xor rax, rax
  ret

%endif
