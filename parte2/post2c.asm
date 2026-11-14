; post2c.asm - MUL/DIV: calculadora de digitos
; Compilar: nasm -f bin post2c.asm -o post2c.com
ORG 100h

section .data
  pA     db 'Primer operando (0-9): $'
  pB     db 0Dh,0Ah,'Segundo operando (0-9): $'
  msgOp  db 0Dh,0Ah,'Operacion (* o /): $'
  msgR   db 0Dh,0Ah,'Resultado: $'
  msgErr db 0Dh,0Ah,'Division por cero.$'
  crlf   db 0Dh,0Ah,'$'

section .text
start:
  mov ah, 09h
  mov dx, pA
  int 21h
  mov ah, 01h
  int 21h
  sub al, 30h
  mov bl, al

  mov ah, 09h
  mov dx, pB
  int 21h
  mov ah, 01h
  int 21h
  sub al, 30h
  mov cl, al

  mov ah, 09h
  mov dx, msgOp
  int 21h
  mov ah, 01h
  int 21h
  mov bh, al

  mov ah, 09h
  mov dx, msgR
  int 21h

  cmp bh, 2Ah
  je  .mul
  cmp bh, 2Fh
  je  .div
  jmp .fin

.mul:
  mov al, bl
  mul cl
  call imprimirAX
  jmp .fin

.div:
  cmp cl, 0
  je  .divCero
  xor ah, ah
  mov al, bl
  div cl
  xor ah, ah
  call imprimirAX
  jmp .fin

.divCero:
  mov ah, 09h
  mov dx, msgErr
  int 21h

.fin:
  mov ah, 09h
  mov dx, crlf
  int 21h
  mov ah, 4Ch
  xor al, al
  int 21h

imprimirAX:
  mov bx, 10
  xor cx, cx
.divide:
  xor dx, dx
  div bx
  push dx
  inc cx
  test ax, ax
  jnz .divide
.popDigit:
  pop dx
  add dl, 30h
  mov ah, 02h
  int 21h
  loop .popDigit
  ret
