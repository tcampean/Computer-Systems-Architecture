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
    a dw -50
    b db 10
    e dd 2
    x dq 4
    y dq 0
    z dw 0
    w dd 0
    
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax,[a]
        cwde ; eax = a
        mov ebx,2
        imul ebx ; edx:eax= 2*a
        mov DWORD [y],eax
        mov DWORD [y+4],edx ; y = 2 *a
        mov al,[b]
        cbw
        cwde 
        cdq ; edx:eax = b
        sub DWORD[y],eax
        sbb DWORD[y+4],edx; y = 2*a-b
        mov al,[b]
        imul BYTE [b]
        cwde ; eax= b*b
        mov [z],eax ; z = b*b
        mov eax,DWORD[y] 
        mov edx,DWORD[y+4] ; edx:eax = 2*a-b
        idiv WORD [z] ; eax = (2*a-b)/(b*b)
        mov [w],eax ;w = (2*a-b)/(b*b)
        mov al,[b] ; al =b
        cbw
        cwde
        cdq ; edx:eax = b
        sub DWORD[x],eax
        sbb DWORD[x+4],edx ; x= x -b
        mov eax,8
        cdq
        add DWORD [x],eax
        adc DWORD [x+4],edx ; x=x-b+8
        mov eax,[w] ; eax =(2*a-b)/(b*b)
        cdq ; edx:eax=(2*a-b)/(b*b)
        add DWORD[x],eax
        adc DWORD[x+4],edx ;x = x-b+8 + (2*a-b)/(b*b)
        mov eax,[e]
        cdq ;edx:eax = e
        add eax,DWORD[x]
        adc edx,DWORD[x+4] ; edx:eax = x-b+8 + (2*a-b)/(b*b) + e
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
     
        
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
