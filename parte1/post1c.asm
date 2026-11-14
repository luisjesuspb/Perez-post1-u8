; post1c.asm - REPNE SCASB: buscar caracter (soporta posiciones de 2 digitos)
; Compilar: nasm -f bin post1c.asm -o post1c.com
ORG 100h

section .data
  cadena  db "Arquitectura de Computadores",0
  longCad equ 29         ; longitud sin el nulo
  msgHall db "Hallado en posicion: $"
  msgNoH  db "No encontrado.$"
  crlf    db 0Dh,0Ah,"$"

section .text
start:
  mov ax, ds
  mov es, ax

  mov di, cadena
  mov al, "d"         ; caracter a buscar
  mov cx, longCad
  cld
  repne scasb
  jne .noHallado      ; ZF=0 al terminar -> no encontrado

  ; Calcular la posicion: DI actual - inicio - 1
  mov bx, di
  sub bx, cadena
  dec bx              ; posicion base-0 (13 para 'd')

  ; Mostrar mensaje
  mov ah, 09h
  mov dx, msgHall
  int 21h

  ; Imprimir BX en decimal (1 o 2 digitos)
  mov ax, bx
  mov cl, 10
  div cl              ; AL = decenas, AH = unidades
  push ax
  cmp al, 0
  je  .soloUnidades
  mov dl, al
  add dl, 30h
  mov ah, 02h
  int 21h
.soloUnidades:
  pop ax
  mov dl, ah
  add dl, 30h
  mov ah, 02h
  int 21h

  mov ah, 09h
  mov dx, crlf
  int 21h
  jmp .fin

.noHallado:
  mov ah, 09h
  mov dx, msgNoH
  int 21h
.fin:
  mov ah, 4Ch
  xor al, al
  int 21h