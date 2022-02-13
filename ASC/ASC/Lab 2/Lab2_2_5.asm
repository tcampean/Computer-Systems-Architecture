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
        a db 3
        b db 2
        c db 10
        d db 4
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[c] ;AL=10
        sub al,[a] ;AL=AL - 3 ; AL = 7
        sub al,[d] ;AL= AL -4 ; AL =3
        
        mov bl,[c] ;BL = 10
        sub bl,[b] ;bl = bl -2
        
        add al,bl ;AL = AL +BL
        sub al,[a] ;AL=AL -a
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
