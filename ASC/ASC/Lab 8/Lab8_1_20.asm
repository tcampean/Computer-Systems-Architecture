bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf          ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    message1 db "a=", 0
    message2 db "b=", 0
    format db "%x", 0
    afisaresum db "sum= %x",0
    afisaredif db "difference = %x",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword message1
        call [printf]      ; we will print 'a='
        add esp, 4*1
        
        push dword a      
        push dword format
        call [scanf]        ; we will take the value of a
        add esp, 4 * 2 
        
        push dword message2
        call [printf]      ; we print 'b='
        add esp, 4*1
        
        push dword b    
        push dword format ; we take the value of b
        call [scanf]   
        add esp, 4 * 2 
        
        mov eax,[a] ; we put a in eax
        mov ebx,[b] ; we put b in ebx
        
        mov eax,[a]
        shr eax, 16 ; we take the high part of eax
        
        mov ebx,[b]
        shr ebx,16 ; we get the high part of ebx
        sub eax,ebx ; we compute the difference
        
        push dword eax
        push dword afisaredif 
        call [printf] ; we show the message with the result
        add esp, 4 * 2 
        
        mov eax,[a]
        mov ebx, [b]
        add ax,bx ; we add the lower parts of ebx and eax
        mov dx,0
        push dx
        push ax
        pop eax
        
        push dword eax
        push dword afisaresum ; we show the message with the result
        call [printf]
        add esp,4*2
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
