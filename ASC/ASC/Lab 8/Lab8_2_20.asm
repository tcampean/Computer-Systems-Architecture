; The following code will open a file called "ana.txt" from current folder,
; it will read maximum 100 characters from this file,
; and it will display to the console the number of chars and the text we've read.

; The program will use:
; - the function fopen() to open/create the file
; - the function fread() to read from file
; - the function printf() to display a text
; - the function fclose() to close the created file.

; Because the fopen() call uses the file access mode "r", the file will be open for
; reading. The file must exist, otherwise the fopen() call will fail.
; For details about the file access modes see the section "Theory".

; Any string used by printf() must be null-terminated ('\0').

bits 32

global start

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ex20.txt", 0   ; filename to be read
    access_mode db "w", 0       ; file access mode:
                                ; r - opens a file for reading. The file must exist
    file_descriptor dd -1
    sum dd 0
    text db "ana coase"; string to hold the text to be written on the file
    len equ $-text
    d times len db 0 ; the string which will store the modified string

; our code starts here
segment code use32 class=code
    start:
       ; call fopen() to create the file
        ; fopen() will return a file descriptor in the EAX or 0 in case of error
        ; eax = fopen(file_name, access_mode)
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2                ; clean-up the stack

        mov [file_descriptor], eax  ; store the file descriptor returned by fopen

        mov ecx,-1
        mov esi, 0
        mov ebx,0
        mov eax,0
        mov edi,0
        
        cld
        Check: ; we start going through the elements of the file one by one
            add ecx,1
            cmp ecx,len
            je final ; if we reach the end of the text we will print the string and exit
            add bl,1 ; will hold the count
            mov al, [text+esi] ; we put the element in al
            jmp compare3
            
        loop Check
        
        
        addition: ; upon comparison if the element is a special caracter then we raise the count
            test ecx,1
            jnz addindex ; we check wether or not ecx is odd or even
            mov [d+esi],al ; if it's odd then we are going to put the element as it is
            inc esi
            jmp Check
        compare3:
            cmp al,122 ; we check if the element is a lowercase letter
            jbe compare4
            mov [d+esi],al ; if its not we are just going to put the normal element
            inc esi
            jmp Check
        compare4:
            cmp al,97
            jae addition ;if the element is a letter then we will go through the addition
            mov [d+esi],al ; if the element is not a lowercase letter then we are just going to add it normally
            inc esi
            jmp Check    
        addindex:
            add bl,'0'
            mov [d+esi],bl ; if the element position is even then we are going to change it with it's position
            sub bl,'0'
            inc esi
            jmp Check
        
       

      final:
        
     ; write the text to file using fprintf()
        ; fprintf(file_descriptor, text)
        push dword d
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2

        ; call fclose() to close the file
        ; fclose(file_descriptor)
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        ; exit(0)
        push dword 0
        call [exit]