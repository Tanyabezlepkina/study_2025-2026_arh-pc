%include 'in_out.asm'

SECTION .data
msg1 db 'Функция: f(x)=3(10+x)',0
msg2 db 'Результат: ',0
SECTION .bss
res resb 10

SECTION .text
global _start

; Подпрограмма f(x) = 3(10+x)
_fx:
    add eax, 10   ; x + 10
    mov ebx, 3    ; умножаем на 3
    mul ebx       ; 3 * (x+10)
    ret

_start:
    ; Выводим что вычисляем
    mov eax, msg1
    call sprintLF
    
    ; Берём количество аргументов
    pop ecx       ; argc
    dec ecx       ; минус имя программы
    mov edx, ecx  ; сохраняем сколько аргументов
    
    ; Если нет аргументов - конец
    cmp ecx, 0
    je _end
    
    ; Сумма = 0
    xor ebx, ebx
    
_next:
    ; Берём аргумент
    pop eax
    call atoi     ; строку в число
    
    ; Считаем f(x)
    call _fx
    
    ; Добавляем к сумме
    add ebx, eax
    
    ; Следующий аргумент
    loop _next
    
    ; Выводим результат
    mov eax, msg2
    call sprint
    mov eax, ebx
    call iprintLF
    
_end:
    call quit
