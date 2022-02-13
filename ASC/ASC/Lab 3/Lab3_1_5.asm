its 32 ; assembling for the 32 bits architecture

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
    x dq 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx,[c] ;ebx = a
        mov al,[a] ;al = a
        mov ah,0   ; ax = al
        mov dx,0    ; dx:ax = ax
        push dx
        push ax
        pop eax ; eax = dx:ax
        sub ebx,eax ; ebx= ebx - eax / c-a
        mov eax, ebx ; eax= c-a
        mov edx,0 ; edx:eax = eax
        sub eax,DWORD [d] 
        sbb edx,DWORD [d+4] ;edx:eax = c-a-d
        mov DWORD [x],eax   
        mov DWORD [x+4],edx ; x= edx:eax= c-a-d
        mov ebx,[c] ; ebx = c
        mov ax,[b] 
        mov dx,0
        push dx
        push ax
        pop eax ;eax = b
        sub ebx,eax ; ebx= c-b
        mov eax,ebx ; eax=c-b
        mov edx,0 ; ; edx:eax= c-b
        add DWORD [x],eax
        adc DWORD [x+4],edx ; x = (c-a-d) + (c-b)
        mov al,[a] ; al=a
        mov ah,0 ; ax=a
        mov dx,0 ; dx:ax=a
        push dx
        push ax
        pop eax ; eax = a
        mov edx,0 ; edx:eax = a
        sub DWORD[x],eax
        sbb DWORD[x+4],edx ; x = (c-a-d)+(c-b)-a
        mov eax,DWORD [x]
        mov edx,DWORD [x+4]
        
        
        
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
