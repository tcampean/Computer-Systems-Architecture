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
        e dw 5
        f dw 7
        g dw 9
        h dw 8
; our code starts here
segment code use32 class=code
    start
        ; ...
        mov al,[a]
        add al,[b]
        add al,[c]
        mov bl,2
        mul bl
        mov dx,3
        mul dx
        div word [g]
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
