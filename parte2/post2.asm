; post2.asm - ADC y SBB: suma y resta de 32 bits
; Compilar: nasm -f bin post2.asm -o post2.com
ORG 100h

section .data
  ; Suma: A = 0x0001FFFF, B = 0x00010001 -> 0x00030000
  aLo      dw 0FFFFh
  aHi      dw 0001h
  bLo      dw 0001h
  bHi      dw 0001h
  resLo    dw 0
  resHi    dw 0
  msgSuma  db "Suma OK: 0003:0000",0Dh,0Ah,"$"
  msgResta db "Resta OK: 0001:FFFF",0Dh,0Ah,"$"
  msgErr   db "Error aritmetico.",0Dh,0Ah,"$"

section .text
start:
  ; --- Paso 1: Suma de 32 bits con ADC ---
  mov ax, [aLo]
  mov dx, [aHi]
  mov bx, [bLo]
  mov cx, [bHi]

  add ax, bx          ; sumar partes bajas: FFFFh + 0001h = 0000h, CF=1
  adc dx, cx          ; sumar partes altas + CF: 0001h + 0001h + 1 = 0003h

  mov [resLo], ax
  mov [resHi], dx

  cmp ax, 0000h
  jne .error
  cmp dx, 0003h
  jne .error

  mov ah, 09h
  mov dx, msgSuma
  int 21h

  ; --- Paso 2: Resta de 32 bits con SBB ---
  ; A = 0x00030000, B = 0x00010001 -> Esperado: 0x0001FFFF
  mov ax, 0000h       ; parte baja de A
  mov dx, 0003h       ; parte alta de A
  mov bx, 0001h       ; parte baja de B
  mov cx, 0001h       ; parte alta de B

  sub ax, bx          ; 0000h - 0001h = FFFFh, CF=1 (prestamo)
  sbb dx, cx          ; 0003h - 0001h - CF(1) = 0001h

  cmp ax, 0FFFFh
  jne .error
  cmp dx, 0001h
  jne .error

  mov ah, 09h
  mov dx, msgResta
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