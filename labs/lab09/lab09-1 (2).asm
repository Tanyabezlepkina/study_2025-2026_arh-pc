%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB 'f(g(x)) = 2*(3x-1)+7 = ',0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
GLOBAL _start
_start:
    ; Ввод x
    mov eax, msg
    call sprint
    mov ecx, x
    mov edx, 80
    call sread
    
    ; Преобразование строки в число
    mov eax, x
    call atoi        ; результат в eax
    
    ; Вызов главной подпрограммы
    call _calcul     ; вызов _calcul с x в eax
    
    ; Вывод результата
    mov eax, result
    call sprint
    mov eax, [res]   ; берем результат из переменной res
    call iprintLF
    
    call quit

; ============================================
; Подпрограмма _calcul
; Вычисляет f(g(x)) = 2*(3x-1)+7
; Вход:  x в eax
; Выход: результат в [res]
; Использует: подпрограмму _subcalcul
; ============================================
_calcul:
    push ebx        ; Сохраняем ebx (по соглашению)
    push ecx        ; Сохраняем ecx
    
    ; 1. Вычисляем g(x) = 3x - 1
    call _subcalcul ; результат g(x) в eax
    
    ; 2. Теперь вычисляем f(g(x)) = 2*g(x) + 7
    ; где g(x) уже в eax
    mov ebx, 2
    mul ebx         ; eax = 2 * g(x)
    
    add eax, 7      ; eax = 2*g(x) + 7
    
    ; 3. Сохраняем результат
    mov [res], eax  ; сохраняем результат в переменную res
    
    ; Восстанавливаем регистры
    pop ecx
    pop ebx
    ret

; ============================================
; Подпрограмма _subcalcul
; Вычисляет g(x) = 3x - 1
; Вход:  x в eax
; Выход: g(x) в eax
; ============================================
_subcalcul:
    ; g(x) = 3x - 1
    mov ebx, 3      ; ebx = 3
    mul ebx         ; eax = 3 * x
    
    sub eax, 1      ; eax = 3x - 1
    ret
