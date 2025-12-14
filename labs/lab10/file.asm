%include 'in_out.asm'

SECTION .data
    filename db 'file.txt', 0h
    prompt db 'What is your name? ', 0
    message db 'My name is ', 0

SECTION .bss
    name resb 100

SECTION .text
global _start

_start:
    ; 1. Приглашение на английском
    mov eax, prompt
    call sprint

    ; 2. Ввод имени
    mov ecx, name
    mov edx, 100
    call sread
    
    ; 3. Создание файла
    mov ecx, 577
    mov ebx, filename
    mov eax, 5
    int 80h
    mov edi, eax

    ; 4. Запись "My name is " (11 символов)
    mov edx, 11
    mov ecx, message
    mov ebx, edi
    mov eax, 4
    int 80h

    ; 5. Запись имени (длина уже в eax от sread)
    mov edx, eax
    mov ecx, name
    mov ebx, edi
    mov eax, 4
    int 80h

    ; 6. Закрытие файла
    mov ebx, edi
    mov eax, 6
    int 80h

    call quit
