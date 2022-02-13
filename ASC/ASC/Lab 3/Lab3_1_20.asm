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
    a db 4
    b dw 5
    c dd 8
    d dq 10
    x dd 0
    y dq 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a]
        cbw
        cwde
        add eax,[c] ; eax = a + c
        mov [x],eax
        mov ax,[b]
        cwde
        sub [x],eax ; x = a + c -b
        mov al,[a]
        cbw ; ax = al =a
        cwde ; eax = ax = a
        add [x],eax ; x = a + c - b + a
        mov eax,[c]
        cdq ; edx:eax = c
        sub DWORD [d],eax
        sbb DWORD[d+4],edx ; d = d - c
        mov eax,[x] ; eax = a + c - b + a
        cdq
        add eax,DWORD[d]
        adc edx,DWORD[d+4] ;edx:eax = a+c-b+a+d-c
        
        
        
        
     
        
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
