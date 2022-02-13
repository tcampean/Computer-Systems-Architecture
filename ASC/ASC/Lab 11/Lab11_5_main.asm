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
extern QuickMaths
segment data use32 class=data
    ; ...
    a dd 0
    b dd 0
    c dd 0
    message1 db "a=", 0
    message2 db "b=", 0
    message3 db "c=", 0 
    format db "%d", 0
    result db "The result of a+b-c is: %d",0

; our code starts here
segment code use32 public code
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
        
        push dword message3 ; we print 'c='
        call [printf]
        add esp, 4*1
        
        push dword c
        push dword format ; we take the value of c
        call [scanf]
        add esp, 4*2
        
        push dword [c]
        push dword [b]
        push dword [a]
        call QuickMaths ; we push our parameters and call the functon
        
        push eax
        push dword result 
        call [printf] ; we print the result
        add esp, 4*2
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
