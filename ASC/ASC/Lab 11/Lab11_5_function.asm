bits 32 ; assembling for the 32 bits architecture
; our code starts here
global QuickMaths
segment code use32 public code

   
QuickMaths:
    mov eax, [esp +4] ; we put a in eax
    mov ebx,[esp +8] ; we put b in ebx
    mov ecx,[esp+12] ; we put c in ecx
    add eax,ebx
    sub eax,ecx ; we will have eax = a + b - c
    
    ret 4 ; we return the value
