bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf            ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd 10
    b dd 7
    format db "Quotient= %d , Remainder = %d",0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov eax,[a]
        cdq ; we convert the value of eax into a quadword
        div DWORD [b] ; we div the value in edx:eax
        push dword edx
        push dword eax
        push dword format ;we take the results and we format them
        call [printf]       ; we print the corresponding message 
        add esp, 4 * 3    
       
       ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
