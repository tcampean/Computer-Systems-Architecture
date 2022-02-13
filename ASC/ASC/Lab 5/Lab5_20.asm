bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    a db 2, 1, 3, 3, 4, 2, 6
    l_a equ $-a
    b db 4, 5, 7, 6, 2, 1
    l_b equ $-b
    r times l_a + l_b db 0
    d db 2
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, l_b
        mov esi, l_b - 1
        mov edx, 0
     
 
        jecxz End
        Loop_b:
             mov al, [b+esi]
             mov [r+edx], al 
             inc edx
             dec esi
        loop Loop_b
        mov esi, 0
        mov ecx, l_a 
        Loop_a:
            mov al,[a+esi]
            mov bl,al
            mov ah,0
            inc esi
            div BYTE [d]
            cmp ah,0
            je Adding
            loop Loop_a
        Adding:
            mov [r+edx], bl
            cmp ecx,0
            sub ecx,1
            inc edx
            ja Loop_a
            
        End:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
