bits 32 ; assembling for the 32 bits architecture
; our code starts here
global Double
segment code use32 public code

   
Double:
    mov eax, [esp +4] ; we put the value from the stack in eax
    add eax,eax ; we double it and then return it
    
    ret 4
