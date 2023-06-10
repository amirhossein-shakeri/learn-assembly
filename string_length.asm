section .data
    msg db "Hello, world!", 0 ; our string
    nl db 10 ; newline character

section .text
    global _start

_start:
    mov esi, msg ; point to the start of the string
    xor ecx, ecx ; clear counter

loop1:
    lodsb ; load next byte from esi and advance pointer
    test al, al ; check if zero
    jz done ; if yes, jump to done
    inc ecx ; increment counter
    jmp loop1 ; repeat loop

done:
    call num2str ; convert ecx to string in eax
    mov edx, eax ; point to the number string
    mov ah, 9 ; system call for print string
    int 21h ; invoke system call
    mov dl, nl ; load newline character
    mov ah, 2 ; system call for print character
    int 21h ; invoke system call
    mov ah, 4ch ; system call for exit program
    int 21h ; invoke system call

num2str: ; subroutine to convert a number to a string of digits
    pushad ; save all registers
    mov eax, ecx ; load number from ecx
    mov edi, esp ; point to the top of stack
    xor ebx, ebx ; clear ebx for division

loop2:
    xor edx, edx ; clear edx for division
    mov bl, 10 ; set divisor to 10
    div ebx ; divide eax by ebx, quotient in eax, remainder in edx
    add dl, '0' ; convert remainder to ASCII digit
    push dx ; push digit to stack
    test eax, eax ; check if quotient is zero
    jnz loop2 ; if not, repeat loop

done2:
    mov eax, edi ; return pointer to number string in eax
    popad ; restore all registers
    ret ; return from subroutine
