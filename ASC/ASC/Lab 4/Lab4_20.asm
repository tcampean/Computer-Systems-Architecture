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
    a dw 0111011101010111b
    b dw 1001101110111110b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx,0 ; the result will be in here
        mov ax,[a]
        mov dx,0
        push dx
        push ax
        pop eax 
        and eax, 0000_0000_0000_0000_0000_0001_1111_1000b ; we isolate the bits 3-8 of a
        mov cl,3
        ror eax,cl ; we put the isolated bits in the bits 0-5
        or ebx,eax  ; we put the results in ebx
        mov ax,[a]
        mov dx,0
        push dx
        push ax
        pop eax
        and eax, 0000_0000_0000_0000_0001_1111_1100_0000b ; we isolate the bits 6-12 of a
        rol eax,cl ; we put the isolated bits in the bits 9-15
        or ebx,eax ; we put the result in ebx
        mov ax,[b]
        mov dx,0
        push dx
        push ax
        pop eax
        and eax,0000_0000_0000_0000_0000_0000_0001_1100b ; we isolate the bits 2-4 of b
        mov cl,4
        rol eax,cl ; we put the isolated bits in the bits 6-8
        or ebx,eax ; we put the result in ebx
        and ebx, 0000_0000_0000_0000_1111_1111_1111_1111b ; we put in the bits 16-31 the value 0
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
