bits 32
global start 

extern exit,scanf,printf
extern afish

import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll  

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    n dd 0
    sir resd 30
    format  db "%x", 0 
    formatdec db "%d ", 0
    out1 db "Signed: ", 0
    out2 db "%cUnsigned: ", 0

    
; our code starts here
segment code use32 class=code
    start:
    
        mov eax, 1
        mov ecx, 0
        mov edi, sir
        
        continue_reading:
            
            pushad
            push dword n
            push dword format
            call [scanf]
            add esp, 4 * 2
            popad
            
            mov eax, dword[n]
            cmp eax, dword 0
            je finish_reading
         
            inc ecx
            mov eax, dword[n]
            stosd
        
        jmp continue_reading
        finish_reading:
        
        ; "Signed: "
        pushad
        push dword out1
        call [printf]
        add esp, 4
        popad
        
        mov edx, ecx
        mov esi, sir
        Display_numbers_signed:
            
            pushad
            push dword [esi]
            push dword 1
            call afish
            popad
            
            add esi, 4
        loop Display_numbers_signed
        
        ; "Unsigned: "
        pushad
        push dword 10
        push dword out2
        call [printf]
        add esp, 8
        popad
        
        mov ecx, edx
        mov esi, sir
        Display_numbers_unsigned:
            
            pushad
            push dword [esi]
            push dword 2
            call afish
            popad 
            
            add esi, 4
        loop Display_numbers_unsigned
        
        ; exit(0)
        push    dword 0 
        call    [exit] 