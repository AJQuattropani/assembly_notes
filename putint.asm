%define BUFF_DX_UINT 20 ; decimal buff size
%define BUFF_HX_UINT 16 ; hex buff size
%define BUFF_BX_UINT 64 ; binary buff size
%define BUFF_ALLOC_SIZE BUFF_BX_UINT

section .bss
  out_buff resb BUFF_ALLOC_SIZE

%macro putchar 1
  mov out_buff[0], %1 
  push 0x1
  pop rax ; write
  mov rdi, rax ; stdout
  mov rsi, out_buff
  mov rdx, 1
  syscall
%endmacro

%macro putint_hex 1
  mov rdi, %1
  call _putint_hex
%endmacro

%macro putint_dec 1
  mov rdi, %1
  call _putint_dec
%endmacro

%macro putint_bin 1
  mov rdi, %1
  call _putint_bin
%endmacro

section .text
_putint_hex: ; rdi: integer
  mov rax, rdi
  mov rsi, BUFF_HX_UINT-1 ; set to last index
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
  mov out_buff[rsi], al ; map to nums
  dec rsi
  pop rax ; pop divided val
  mov rdi, rax
  cmp rax, 0 ; test if its 0
  jne _pi_l1 ; if its not 0 jump back
  
  push 0x1 ; syscall 1
  pop rax
  mov rdi, rax ; stdout
  mov rsi, out_buff ; pointer to buffer
  mov rdx, BUFF_HX_UINT  ; buff size
  syscall

  xor rax, rax ; return 0
  ret

_putint_dec
  mov rax, rdi ; set rax to rdi 
  mov rsi, BUFF_DX_UINT-1 ; set to last index
  mov rcx, 10
_pi_l2:
  div rcx ; div ax / 10
  push rax ; push divded val
  mul rcx ; mul ax 10
  sub rdi, rax ; remainder
  ; convert into number
  add dil, byte 0x30
  mov out_buff[rsi], dil ; map to nums
  dec rsi
  pop rax ; pop divided val
  cmp rax, 0 ; test if its 0
  mov rdi, rax
  jne _pi_l2 ; if its not 0 jump back
  
  push 0x1 ; syscall 1
  pop rax
  mov rdi, rax ; stdout
  mov rsi, out_buff ;pointer to buffer
  mov rdx, BUFF_DX_UINT
  syscall

  xor rax, rax ; return 0
  ret

_putint_bin:
  mov rax, rdi
  mov rsi, BUFF_BX_UINT-1 ; set to last index
_pi_l3:
  and rdi, 1 ; rightmost bit
  add rdi, 0x30
  mov out_buff[rsi], dil ; map to nums
  shr rax, 1
  mov rdi, rax
  dec rsi
  cmp rax, 0
  jne _pi_l3

  push 0x1 ; syscall 1
  pop rax
  mov rdi, rax ; stdout
  mov rsi, out_buff ; buffer
  mov rdx, BUFF_BX_UINT ; buff size
  syscall

  xor rax, rax
  ret


