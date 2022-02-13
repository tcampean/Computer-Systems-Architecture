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
        mov ebx,[c] ;ebx = c
        mov ax,[b]  ; ax = b
        cwde        ; eax = b
        add ebx,eax ; ebx = c + b
        add ebx,eax ; ebx = c+b+b
        mov [x],ebx ; x = c + b +b
        mov al,[a] ; al= a
        cbw        ; ax = a
        cwde        ; eax = a
        add eax,[c] ;eax = a + c
        cdq         ; edx:eax = a + c
        add eax, DWORD[d]   
        adc edx,DWORD[d+4] ; edx:eax = a + c + d
        sub DWORD[x],eax
        sbb DWORD[x+4],edx ; x = (c+b+b)-(c+a+d)
        mov eax,DWORD[x]
        mov edx,DWORD[x+4] ;edx:eax = (c+b+b)-(c+a+d)
        
        
        
     
        
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
