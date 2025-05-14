
section .text
  global _start, _strlen
_strlen: ; take rdi as an argument
  ; prefix
  push rbp
  mov rbp, rsp
  sub rsp, 0 ; uses no stack space
  push rbx
  push r12
  push r13
  push r14
  push r15
  ; body
  mov rcx, -1
  xor al, al
  repnz scasb ; count until val in rdi = \0
  mov rax, -2
  sub rax, rcx ; save length in rax
  mov rcx, -1
  ; postfix
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
  mov rsp, rbp ; reset the stack
  pop rbp
  ;pop rip
  ret
_start:
  mov rdi, stat_str
  call _strlen
  mov rdi, rax
  mov rax, stat_len
  sub rax, 1
  sub rdi, rax
  push 0x3c ; exit code 60, exit
  pop rax
  syscall
_exit:
  push 0x3c ; exit code 60, exit
  pop rax
  xor rdi, rdi
  syscall
section .data
section .rodata
  stat_str db "Hello, World!",0xA,0x0
  stat_len equ $ - stat_str
section .bss
