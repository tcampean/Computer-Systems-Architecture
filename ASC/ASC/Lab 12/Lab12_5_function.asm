bits 32

global _QuickMaths

segment code public code use32
_QuickMaths:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8] ; we save a in eax
    mov ebx, [ebp + 12] ; we save b in ebx
    add eax, ebx ; we add a to b (a+b)
    mov ebx, [ebp + 16] ; we save c in ebx
    sub eax, ebx ; from eax we substract c (a+b-c)
    
    mov esp, ebp
    pop ebp 
    
    ret