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
    s db 'a', 'A', 'b', 'B', '2', '%', 'x'
    l equ $-s
    d times l db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, l
        mov esi, 0
        mov edx, 0
 
        jecxz End
        Loop:
             mov al, [s+esi]
             cmp al , 97
             inc esi
            jae Comp
            loop Loop
        Comp:
                cmp al,122
                jbe Adding
                cmp ecx,0
                ja Loop
        Adding:
            mov [d+edx],al
            inc edx
            cmp ecx,0
            ja Loop
        End:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
