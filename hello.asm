	section .bss
	; variables

	section .data                ; constants
	msg db "Hello, World!", 0xa  ; define the message
	msgLen equ $ - msg           ; length of the message

	section .text
	global_start                 ; entrypoint

_start:                       ; start here
	mov edx, msgLen
  mov ecx, msg
