bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
;Se citesc de la tastatura doua siruri de caractere. Sa se interclaseze caracterele care compun cele doua siruri si apoi sa se afiseze in fisierul output.txt sirul destinatie, in ordine inversa.

;Sirul 1 citit este: 126789
;Sirul 2 citit este: 12345689

;Sirul interclasat va fi:
;11223456678899

;output.txt
;99887665432211

;Two character arrays are read from the keyboard. Merge the characters from the arrays and print the merging result in the output file in reverse order. 

;The first read array: 126789
;The second read array: 12345689

;The merged result:
;11223456678899

;output.txt
;99887665432211
extern exit, printf, scanf, fopen, fclose,fread,fprintf          ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
     file db "file1.txt",0
    file_desc dd -1
    write_mode db "a", 0
    format_string db "%s",0
    print db "%s",10 , 13,0
    len_1 db 0
    len_2 db 0
    sir_1 resb 100
    sir_2 resb 100
    sir_3 times 200 db 0
   
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword sir_1 ; we read the first string
        push dword format_string
        call [scanf]
        add esp, 4*2
        
        mov esi,sir_1
        lenght_1: ; we compute the length of the first string
                lodsb
                cmp al,0
                je leave1
                add [len_1],byte 1
                jmp lenght_1 
        
        
        leave1:
        push dword sir_2 ; we read the second string
        push dword format_string
        call [scanf]
        add esp , 4*2
        
        mov esi, sir_2
        lenght_2: ; we compute the length of the second string
                lodsb
                cmp al,0
                je leave2
                add [len_2], byte 1
                jmp lenght_2
        
        
        leave2:
        push dword write_mode
        push dword file
        call [fopen]
        add esp, 4*2
        
        mov [file_desc], eax
        cmp eax,0
        je final
        
        mov dl,0
        mov esi , sir_1
        mov edi , sir_2
        mov ebx, 0
        concatenate:
            mov al, [esi]
            mov dl, [edi]
            cmp al,dl ; we compare the elements
            jb add_esi ; if al < dl then we will add al to the 3rd string
            jae add_edi ; if dl < al we will add dl to the 3rd string
        
        
        add_esi:
            mov [sir_3+ebx], al ; we put al in our string
            inc ebx
            inc esi
            jmp concatenate
        
        add_edi:
            mov [sir_3+ebx],dl ; we put dl in our string
            inc ebx
            inc edi
            jmp concatenate
        
        
        
        mov esi,sir_1
        
        lop: ; we go up to the end of the string
            lodsb
            cmp al,0
            je outer
      
        
        outer:
            dec esi
            std ; we set the df = 1 so we can go back
            lodsb
            cbw
            cwde
            push dword eax
            push dword print
            push dword [file_desc]
            call [fprintf] ; we print every digit for the last
            jmp outer
            
        
        
        
        
        
        
        push dword sir_1
        push dword print
        push dword [file_desc]
        call [fprintf]
        add esp, 4*3
        
        push dword sir_2
        push dword print
        push dword [file_desc]
        call [fprintf]
        add esp, 4*2
        
        
        
        
        
        
        
        
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
