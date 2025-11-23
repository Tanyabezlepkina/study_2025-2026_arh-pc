%include 'in_out.asm'

SECTION .data
msg db "Наименьшее число: ",0h
a dd 95
b dd 2  
c dd 61

SECTION .text
GLOBAL _start
_start:

; ---------- Записываем 'a' в переменную 'min'
mov ecx,[a]      ; 'ecx = a'
mov [min],ecx    ; 'min = a'

; ---------- Сравниваем 'min' и 'b'
mov ecx,[min]
cmp ecx,[b]      ; Сравниваем 'min' и 'b'
jl check_c       ; если 'min < b', то переход на метку 'check_c'
mov ecx,[b]      ; иначе 'ecx = b'
mov [min],ecx    ; 'min = b'

; ---------- Сравниваем 'min' и 'c'  
check_c:
mov ecx,[min]
cmp ecx,[c]      ; Сравниваем 'min' и 'c'
jl finish        ; если 'min < c', то переход на метку 'finish'
mov ecx,[c]      ; иначе 'ecx = c'
mov [min],ecx    ; 'min = c'

; ---------- Вывод результата
finish:
mov eax, msg
call sprint      ; Вывод сообщения 'Наименьшее число: '
mov eax,[min]
call iprintLF    ; Вывод минимального числа

call quit        ; Выход

SECTION .bss
min resb 10
