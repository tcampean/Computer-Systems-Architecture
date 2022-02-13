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
    a db 01010111b
    b db 10111110b
    c dw 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov ebx,0 ; the result will be stored in ecx
        mov al,[b]
        mov ah,0
        mov dx,0
        push dx
        push ax
        pop eax ; eax =0000_0000_0000_0000_0000_0000_1011_1110b
        mov cl,3
        and eax , 0000_0000_0000_0000_0000_0000_0111_1000b ; we isolate thr bits 3-6
        ror eax,cl ; we put the bits we isolated on the bits 0-3
        or ebx,eax ; we put the result in ebx
        and ebx , 1111_1111_1111_1111_1111_1111_0000_1111b ; the bits 4-7 will get the value 0
        and ebx, 1111_1111_1111_1111_1111_1110_1111_1111b ; the bit 8 will get the value 0
        or ebx,0000_0000_0000_0000_0000_0110_0000_0000b ; the bits 9-10 will get the value 1
        mov ax,[a]
        mov ah,0
        mov dx,0
        push dx
        push ax
        pop eax
        and eax , 0000_0000_0000_0000_0000_0000_0001_1111b ; we isolate the bits 0-4 of eax
        mov cl ,11
        rol eax,cl ; the isolated bits will be put on the bits 11-15
        or ebx,eax ; we put the result in ebx
        or ebx,1111_1111_1111_1111_0000_0000_0000_0000b ; the bits 16-31 will be set to 1
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
