%include 'in_out.asm'
SECTION .data
div: DB 'Результат: ',0
SECTION .text
GLOBAL _start
_start:
; ---- Вычисление выражения (3+2)*4+5
mov ebx,3
mov eax,2
add ebx,eax    ; EBX = 3+2 = 5
mov eax,ebx    ; ← ДОБАВЛЕНО: переносим 5 в EAX для умножения
mov ecx,4
mul ecx        ; EAX = 5*4 = 20
add eax,5      ; ← ИСПРАВЛЕНО: было add ebx,5
mov edi,eax    ; ← ИСПРАВЛЕНО: было mov edi,ebx

; ---- Вывод результата на экран
mov eax,div
call sprint
mov eax,edi
call iprintLF
call quit
