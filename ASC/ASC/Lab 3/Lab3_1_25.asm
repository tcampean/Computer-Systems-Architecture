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
     mov al,[a] ; al = a
     mov ah,0
     mov dx,0; dx:ax = a
     push dx
     push ax
     pop eax ; eax=a
     mov bx,[b] ;bx=b
     mov cx,0 ;cx:bx=b
     push cx
     push bx
     pop ebx; ebx=b
     add eax,ebx ; eax=a+b
     mov [x],eax ; x= a+b
     mov eax, [c] ;eax=c
     add [x],eax ; x = a+b+c
     mov eax,DWORD[d]
     mov edx,DWORD[d+4] ;edx:eax = d
     add eax,DWORD[d]
     adc edx,DWORD[d+4] ;edx:eax= d+d
     mov ebx,[x]; ebx = a+b+c
     mov ecx,0 ; ecx:ebx = a+b+c
     sub ebx,eax
     sbb ecx,edx ; ebx = a+b+c-(d+d)
     mov DWORD [y],ebx 
     mov DWORD [y+4],ecx ;y = ecx:ebx
     mov ebx,[c] ; ebx = c
     mov ax,[b] ; ax = b
     mov dx,0 ; dx:ax = b
     push dx
     push ax
     pop eax ;eax = b
     add eax,ebx ; eax= b+c
     mov edx,0 ; edx:eax=b+c
     add eax,DWORD[y]
     adc edx,DWORD[y+4] ; edx:eax = (a+b+c) -(d+d) + (b+c)
        
     
        
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
