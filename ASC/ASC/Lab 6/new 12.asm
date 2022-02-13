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
        mov esi, s2
        mov edi, s1
        mov edx,0
        cld
   
        outer_Loop:
           cmp edx,l_s2 ; if we reach the end of the string then we exit the application
           je End
           mov bl, 0 ; we will use bl to track the indexes of the elements
           mov edi,s1 ; we put s1 in edi
           lodsb
        inner_Loop:
            add bl,1 
            scasb ; we compare the values
            je Adding ; ; if they are equal then we found the element and we are going to adds it's position to d string
            jmp inner_Loop
        
        reset_inner:
            inc edx ; we move to the next element in s2
        
            jmp outer_Loop
        Adding:
            cmp bl,l_s1 ; if the index is bigger than the lenght of the string then the element does not exist
            jbe Added ; if it's in range then we are going to add it's index to our string
            inc edx
            jmp outer_Loop
        Added:
            mov [d+edx], bl ; we put the index in it's respective position
            mov bl,0 ; we reset the positioj
            inc edx
            inc ecx
            jmp outer_Loop ; we move onto the next element
        End:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
