bits 32

global _QuickMaths

segment code public code use32
_QuickMaths:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    add eax, ebx
    mov ebx, [ebp + 16]
    sub eax, ebx
    
    mov esp, ebp
    pop ebp
    
    ret