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
        mov edi, d
        mov edx,0
        cld
   
        outer_Loop:
            
           cmp ecx, l_s2
           je End
           mov ebx, -1
           lodsb ; we put an element from the array in al
        inner_Loop:
            cmp ebx, l_s1
            je reset_inner
            inc ebx
            cmp [s1+ebx],al ; we compare the element we stored with each element from the first array
            je Adding ; if we find it then we are going to add it
            jmp inner_Loop
        
        reset_inner:
            inc ecx 
            mov [d+edx],BYTE 0 ; if we didn't find it then we are going to put a zero in it's place instead
            inc edx
        
             jmp outer_Loop
        Adding:
            inc bl
            mov [d+edx], bl ; we put the index of the element in it's position
            dec bl
            inc edx
            inc ecx
            jmp outer_Loop ; we go to the next element
            
        End:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
