; post2b.asm - DAA y DAS: suma y resta BCD empaquetada
; Compilar: nasm -f bin post2b.asm -o post2b.com
ORG 100h

section .data
  bcd1       db 47h        ; BCD empaquetado: "47"
  bcd2       db 38h        ; BCD empaquetado: "38"
  resultado  db 0
  msg        db "BCD suma: $"
  msgCarry   db "DAA acarreo (99+01): 00 con CF=1",0Dh,0Ah,"$"
  msgDas1    db "DAS OK: 45",0Dh,0Ah,"$"
  msgDas2    db "DAS prestamo OK: 19",0Dh,0Ah,"$"
  msgErr     db "Error en ajuste BCD.",0Dh,0Ah,"$"
  crlf       db 0Dh,0Ah,"$"

section .text
start:
  ; --- 1. Suma BCD con DAA: 47 + 38 = 85 ---
  mov al, [bcd1]
  add al, [bcd2]      ; AL = 47h + 38h = 7Fh (NO es BCD valido)
  daa                 ; ajustar: AL = 85h (resultado BCD correcto)
  mov [resultado], al

  mov ah, 09h
  mov dx, msg
  int 21h

  mov al, [resultado]
  mov bl, al
  shr al, 4            ; nibble alto (decenas)
  add al, 30h
  mov dl, al
  mov ah, 02h
  int 21h

  mov al, bl
  and al, 0Fh          ; nibble bajo (unidades)
  add al, 30h
  mov dl, al
  int 21h

  mov ah, 09h
  mov dx, crlf
  int 21h

  ; --- 2. Prueba de acarreo BCD: 99 + 01 = 00 (CF=1) ---
  mov al, 99h
  add al, 01h          ; AL = 9Ah
  daa                  ; AL = 00h, CF = 1
  jnc .error
  cmp al, 00h
  jne .error
  mov ah, 09h
  mov dx, msgCarry
  int 21h

  ; --- 3. Resta BCD con DAS: 73 - 28 = 45 ---
  mov al, 73h
  sub al, 28h          ; AL = 4Bh (NO BCD valido)
  das                  ; AL = 45h (correcto)
  cmp al, 45h
  jne .error
  mov ah, 09h
  mov dx, msgDas1
  int 21h

  ; --- 4. Resta BCD con prestamo: 20 - 01 = 19 ---
  mov al, 20h
  sub al, 01h          ; AL = 1Fh (nibble bajo Fh > 9)
  das                  ; AL = 19h (correcto), CF = 0
  cmp al, 19h
  jne .error
  mov ah, 09h
  mov dx, msgDas2
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