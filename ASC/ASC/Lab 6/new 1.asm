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
    
    s1 db 7, 33, 55, 19, 46
    l_s1 equ $-s1
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    l_s2 equ $-s2
    d times l_s2 db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, 0
        mov ecx,0
        mov esi, s2
        mov edi, s1
        mov edx,0
        cld
   
        outer_Loop:
             ;mov al, [b+esi]
             ;inc esi
            
           cmp ecx, l_s2
           je End
           lodsb
           mov ebx,-1
        inner_Loop:
             
            scasb
            je Adding
        Loop inner_Loop
        
        reset_inner:
            inc ecx
            inc edx
        
            jmp outer_Loop
        Adding:
            mov [d+edx], BYTE edi
            inc ecx
            inc edx
            jmp outer_Loop
            
        End:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
