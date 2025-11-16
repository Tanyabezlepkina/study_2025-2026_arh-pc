SECTION .data

    msg: DB 'Введите строку: ',0h     ; сообщение

SECTION .bss
    buf1: RESB 80                     ; Буфер размером 80 байт

SECTION .text
    GLOBAL _start

_start:
    ; Вывод приглашения "Введите строку: "
    mov eax, 4              ; системный вызов sys_write
    mov ebx, 1              ; файловый дескриптор stdout
    mov ecx, msg            ; указатель на строку
    mov edx, 16             ; длина строки (16 символов)
    int 0x80                ; вызов ядра

    ; Ввод строки с клавиатуры
    mov eax, 3              ; системный вызов sys_read
    mov ebx, 0              ; файловый дескриптор stdin
    mov ecx, buf1           ; указатель на буфер
    mov edx, 80             ; максимальная длина ввода
    int 0x80                ; вызов ядра

    ; Сохраняем длину введенной строки
    mov esi, eax            ; sys_read возвращает длину в eax

    ; Вывод введенной строки
    mov eax, 4              ; системный вызов sys_write
    mov ebx, 1              ; файловый дескриптор stdout
    mov ecx, buf1           ; указатель на буфер с введенной строкой
    mov edx, esi            ; длина введенной строки
    int 0x80                ; вызов ядра

    ; Завершение программы
    mov eax, 1              ; системный вызов sys_exit
    mov ebx, 0              ; код возврата
    int 0x80                ; вызов ядра
