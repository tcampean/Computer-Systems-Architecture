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
    a dd 5
    b db 10
    c dw 2
    x dq 4
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[b]
        mov ah,0
        mov dx,0
        div WORD [c] ; ax = b/c
        mov dx,0
        push dx
        push ax
        pop eax
        add eax, [a]
        sub eax,1 ; eax = a+b/c-1
        mov edx,0
        mov bl,[b]
        mov bh,0
        mov cx,0
        push cx
        push bx
        pop ebx ; ebx = b
        add ebx,2
        div ebx ; eax = (a+b/c-1)/(b+2)
        mov edx,0
        sub eax,DWORD[x]
        sbb edx,DWORD[x+4] ;eax = (a+b/c-1)/(b+2) - x
        
        
        
        
        
        
        
        
        
        
     
        
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
