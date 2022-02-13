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
extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ex5.txt", 0   ; filename to be read
    access_mode db "r", 0       ; file access mode:
                                ; r - opens a file for reading. The file must exist.
    file_descriptor dd -1       ; variable to hold the file descriptor
    len equ 100                 ; maximum number of characters to read
    text times (len+1) db 0     ; string to hold the text which is read from file
    format db "The number of special characters in the text is %d", 0

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

        ; check if fopen() has successfully created the file (EAX != 0)
        cmp eax, 0
        je final

        ; read the text from file using fread()
        ; after the fread() call, EAX will contain the number of chars we've read 
        ; eax = fread(text, 1, len, file_descriptor)
        push dword [file_descriptor]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4

        mov ecx,eax
        mov esi, text
        mov ebx,0
        
        cld
        Check: ; we start going through the elements of the file one by one
            cmp ecx,0 
            jbe final
            lodsb ; we put the element in al
            ; we will compare it with the ascii code of each of the characters a-z A-Z and 0-9
            cmp al, 122
            ja addition
            cmp al, 97
            jb compare1
            cmp al, 65
            jb compare2
            cmp al,48
            jb addition
        loop Check
        
        
        addition: ; upon comparison if the element is a special caracter then we raise the count
            add ebx,1
            cmp ecx,0
            sub ecx,1
            jae Check
        compare1:
            cmp al,90
            ja addition ; if the element is not a letter
            jb compare2
            
        compare2:
            cmp al,65
            jb compare3
            sub ecx,1
            jae Check
        compare3:
            cmp al,57
            ja addition ; if the element is not a number
            jb compare4
        compare4:
            cmp al,48
            jb addition ;if the element is not a number
            sub ecx,1
            jae Check
         
       

      final:
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        push dword ebx
        push dword format
        call [printf]
        add esp, 4*2
        ; exit(0)
        push dword 0
        call [exit]