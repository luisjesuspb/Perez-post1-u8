; post2.asm - ADC: suma de 32 bits
; Compilar: nasm -f bin post2.asm -o post2.com
ORG 100h

section .data
  ; A = 0x0001FFFF = 131071 decimal
  ; B = 0x00010001 = 65537 decimal
  ; Esperado: A + B = 0x00030000 = 196608 decimal
  aLo    dw 0FFFFh      ; parte baja de A
  aHi    dw 0001h       ; parte alta de A
  bLo    dw 0001h       ; parte baja de B
  bHi    dw 0001h       ; parte alta de B
  resLo  dw 0           ; resultado parte baja
  resHi  dw 0           ; resultado parte alta
  msg    db "Suma OK: 0003:0000",0Dh,0Ah,"$"
  msgErr db "Error en suma.",0Dh,0Ah,"$"

section .text
start:
  mov ax, [aLo]
  mov dx, [aHi]
  mov bx, [bLo]
  mov cx, [bHi]

  add ax, bx          ; sumar partes bajas: CF puede activarse
  adc dx, cx          ; sumar partes altas + CF

  mov [resLo], ax
  mov [resHi], dx

  ; Verificar resultado esperado
  cmp ax, 0000h
  jne .error
  cmp dx, 0003h
  jne .error

  mov ah, 09h
  mov dx, msg
  int 21h
  jmp .fin
.error:
  mov ah, 09h
  mov dx, msgErr
  int 21h
.fin:
  mov ah, 4Ch
  xor al, al
  int 21h