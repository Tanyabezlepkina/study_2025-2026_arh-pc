%include 'in_out.asm'

SECTION .data
msg_func db "Функция: f(x)=3(10+x)",0
msg_result db "Результат: ",0

SECTION .text
global _start

_start:
    pop ecx             ; Количество аргументов (argc)
    pop edx             ; Имя программы (argv[0])
    sub ecx, 1          ; Убираем имя программы из счётчика
    mov esi, 0          ; Начальная сумма = 0

    ; Вывод информации о функции
    mov eax, msg_func
    call sprintLF

next:
    cmp ecx, 0
    jz _end

    pop eax             ; Берём очередной аргумент
    call atoi           ; Преобразуем строку в число (x)

    ; Вычисляем f(x) = 3(10 + x) = 30 + 3x
    mov ebx, eax        ; ebx = x (сохраняем на всякий случай)
    add eax, 10         ; eax = x + 10
    mov edi, 3          ; edi = 3
    imul eax, edi       ; eax = 3*(x + 10) = 30 + 3x

    ; Добавляем к сумме
    add esi, eax

    loop next

_end:
    mov eax, msg_result
    call sprint
    mov eax, esi
    call iprintLF
    call quit
