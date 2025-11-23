%include 'in_out.asm'

SECTION .data
msg_x db "Введите x: ",0h
msg_a db "Введите a: ",0h  
msg_res db "Результат f(x): ",0h

SECTION .bss
x resb 10
a resb 10
res resb 10

SECTION .text
GLOBAL _start
_start:

; ---------- Ввод x ----------
mov eax, msg_x
call sprint
mov ecx, x
mov edx, 10
call sread
mov eax, x
call atoi
mov [x], eax

; ---------- Ввод a ----------
mov eax, msg_a
call sprint
mov ecx, a
mov edx, 10
call sread
mov eax, a
call atoi
mov [a], eax

; ---------- Вычисление функции ----------
mov ebx, [x]
mov ecx, [a]

; Сравниваем x и a
cmp ebx, ecx
jl less_case    ; если x < a, переходим к случаю x < a

; Случай x ≥ a: f(x) = x - a
greater_case:
sub ebx, ecx   ; ebx = x - a
mov [res], ebx
jmp output

; Случай x < a: f(x) = 5
less_case:
mov ebx, 5
mov [res], ebx

; ---------- Вывод результата ----------
output:
mov eax, msg_res
call sprint
mov eax, [res]
call iprintLF

call quit
