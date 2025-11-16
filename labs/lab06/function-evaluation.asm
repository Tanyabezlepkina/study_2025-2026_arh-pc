%include 'in_out.asm'

SECTION .data
    msg db 'Вычисление функции y = (x^3 / 3) + 21',0
    input_msg db 'Введите значение x: ',0
    result_msg db 'Результат: y = ',0

SECTION .bss
    x resb 10

SECTION .text
GLOBAL _start
_start:
    ; Вывод выражения для вычисления
    mov eax, msg
    call sprintLF

    ; Запрос ввода x
    mov eax, input_msg
    call sprint
    mov ecx, x
    mov edx, 10
    call sread

    ; Преобразование введенного x в число
    mov eax, x
    call atoi

    ; ===== ВЫЧИСЛЕНИЕ y = (x^3 / 3) + 21 =====
    
    ; Сохраняем x в другом регистре
    mov ebx, eax    ; EBX = x
    
    ; Вычисляем x^2 = x * x
    mul ebx         ; EAX = x * x = x²
    
    ; Вычисляем x^3 = x² * x
    mul ebx         ; EAX = x² * x = x³
    
    ; Делим x³ на 3 (используем только целую часть)
    mov ebx, 3      ; EBX = 3
    xor edx, edx    ; Обнуляем EDX для деления
    div ebx         ; EAX = x³ / 3 (целая часть)
    
    ; Прибавляем 21
    add eax, 21     ; EAX = (x³ / 3) + 21
    
    ; ===== ВЫВОД РЕЗУЛЬТАТА =====
    mov ebx, eax    ; Сохраняем результат в EBX
    
    ; Вывод сообщения о результате
    mov eax, result_msg
    call sprint
    
    ; Вывод самого результата
    mov eax, ebx
    call iprintLF
    
    ; Завершение программы
    call quit
