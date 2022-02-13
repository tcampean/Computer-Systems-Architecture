bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    reg_hex DB 'hex      EAX: %10x, EDX: %10x, ECX: %10x, EBX: %10x, ESP: %10x, EBP: %10x, ESI: %10x, EDI: %10x', 10,  0
    reg_unsgined DB 'unsinged EAX: %10u, EDX: %10x, ECX: %10u, EBX: %10u, ESP: %10u, EBP: %10u, ESI: %10u, EDI: %10u', 10,  0
    reg1_signed dB 'signed   EAX: %10d, EDX: %10d, ECX: %10d, EBX: %10d, ', 0
    reg2_signed dB 'ESP: %10d, EBP: %10d, ESI: %10d, EDI: %10d', 10, 0
    
    space DB " ", 0
    new_line DB 10, 0

; our code starts here
segment code use32 class=code
    start:
        ; write code here:
        
        ; example
        CALL print_regs
        mov al, 250 >>4
        CALL print_regs
        mov al,0FFFFh>>4
        CALL print_regs
         
        
        
        jmp end_of_FUNCTIONS
        ; DO NOT WRITE CODE HERE CUZ IT WILL BE SKIPPED
        FUNCTIONS:
        
            print_regs;
                PUSHAD
                
                CALL print_new_line
                CALL print_reg_hex
                CALL print_reg_unsigned
                CALL print_reg_dec
                CALL print_new_line
                CALL print_new_line
                
                POPAD
                RET
            print_reg_hex:
                PUSH EBP
                MOV EBP, ESP
                PUSHAD
                
                PUSH EDI
                PUSH ESI
                PUSH EBP
                PUSH ESP

                PUSH EBX
                PUSH ECX
                PUSH EDX
                PUSH EAX
                PUSH DWORD reg_hex
                call [printf]
                ADD ESP, 4*9
                
                POPAD
                POP EBP
                RET
            print_reg_unsigned:
                PUSH EBP
                MOV EBP, ESP
                PUSHAD
                
                PUSH EDI
                PUSH ESI
                PUSH EBP
                PUSH ESP

                PUSH EBX
                PUSH ECX
                PUSH EDX
                PUSH EAX
                PUSH DWORD reg_unsgined
                call [printf]
                ADD ESP, 4*9
                
                POPAD
                POP EBP
                RET
            print_reg_dec:
                PUSH EBP
                MOV EBP, ESP
                PUSHAD
                
                PUSH EBX
                PUSH ECX
                PUSH EDX
                PUSH EAX
                PUSH DWORD reg1_signed
                call [printf]
                ADD ESP, 4*5
                
                PUSH EDI
                PUSH ESI
                PUSH EBP
                PUSH ESP
                PUSH DWORD reg2_signed
                call [printf]
                ADD ESP, 4*5
                
                POPAD
                POP EBP
                RET
            
            print_space:
                PUSHAD
                
                PUSH DWORD space
                CALL [printf]
                ADD ESP, 1*4
                
                POPAD
                RET
            print_new_line:
                PUSHAD
                
                PUSH DWORD new_line
                CALL [printf]
                ADD ESP, 1*4
                
                POPAD
                RET 
            
        end_of_FUNCTIONS:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

