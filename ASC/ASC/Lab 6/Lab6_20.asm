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
    s1 db 'capac lcadea aero cecec'
    l_s1 equ $-s1
    d db ' '
    pali times l_s1/2 db 0
    pasebx dd 0
    pasecx dd 0
    pas dd 0
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx,0
        mov edx,0
        mov ecx,0
        mov esi, s1
        cld
        
        yes:
            
            mov ebx,[pasebx]
            mov ecx,[pasebx]   ; we pass the last position to ebx and ecx
            cmp ecx,l_s1
            jae End
            mov al,byte [esi + ecx] ; we put in al the first letter of the word
            jmp verify
            
        verify:
            cmp [s1+ebx], byte ' ' ; we go trough the word up to the end of it when we find a space
            je plus ; if we find it then we are going to jump further
            inc ebx
            mov [pasebx],ebx
            add [pasebx],DWORD 1
            jmp verify
            
        plus:
            dec ebx
            mov dl, byte [esi + ebx] ; we put in dl the last letter of the word
            mov [pasecx],ecx
            sub [pasecx], DWORD 1
            jmp verif
        verif:
            cmp al,dl ; we are going to compare each letter with it's "twin part" in the word
            jne NotPali ; if they are different it means that the word is not a palindrom so we just skip checking it any further
            inc ecx
            dec ebx
            mov al, byte[esi+ecx]
            mov dl, byte[esi+ecx]
            
  
            cmp ebx,ecx ; we check if we passed the middle of the word
            jb Pali
            jmp verif
       Pali:
            mov ebx,[pas]
            mov [pali+ebx], byte 1 ; if it's a palindrom we are going to put in it's respective index in the string pali the value 1
            add [pas], DWORD 1
            jmp yes
       NotPali:
            mov ebx,[pas]
            mov [pali+ebx], byte 0 ; if it's not palindrom then we are going to put 0 in the word's position
            add [pas], DWORD 1
            jmp yes
        
            
       
        End:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
