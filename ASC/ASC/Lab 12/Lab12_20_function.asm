bits 32 ; assembling for the 32 bits architecture
; our code starts here
global _Prime
segment code use32 public code

   
_Prime:
    push ebp
    mov ebp, esp
    mov eax, [esp +8] ; we put the parameter in eax
    
    cmp eax, 2 ; if the number is 0 or 1 then it's not prime
    jb not_prime
    je prime ; if the number is 2 then it's prime
    mov ecx, eax ; we save the number in ecx
    mov ebx,2 ; we put in ebx the value 2
    cdq
    div ebx ; we get in eax the initial number divided by 2 
    mov ebx,eax
    mov eax,ecx
    mov ecx,ebx ; we exchange them : eax will be the initial number and ecx will be it's half
    
    Loop:
        cmp ecx,1 ; if we get to 1 then the number must be prime
        je prime
        mov ebx,eax ; we save eax in ebx
        cdq
        div ecx ; we divide edx:ecx by the current number
        test edx, edx ; we check whether or not edx is 0
        jz not_prime ; if it's zero then the number is not prime
        mov eax,ebx ; we put in eax the initial number
        loop Loop
    
    not_prime:
        mov eax, -1 ; if the number is not prime then we will change it's value to -1
        mov esp,ebp
        pop ebp
        ret ; we return the value
    
    prime:
        mov esp, ebp
        pop ebp
        ret ; we return the value