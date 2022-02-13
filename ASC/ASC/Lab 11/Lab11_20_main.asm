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

extern Double
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    file_name db "ex20.txt", 0   ; filename to be read
    access_mode db "r", 0       ; file access mode:
                                ; r - opens a file for reading. The file must exist.
    file_descriptor dd -1       ; variable to hold the file descriptor
    len equ 100                 ; maximum number of characters to read
    text times (len+1) db 0     ; string to hold the text which is read from file
    format db "%d, ", 0
    a db 10
    string times 100 db 0
    len_string dd 0

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
        mov edx,0
        mov edi,string
        
        
        cld
        Check: ; we start going through the elements of the file one by one
            cmp ecx,0 
            jbe continue
            lodsb ; we put the element in al
            cmp al, ',' ; we check until the end of the number
            je inc_esi
            sub al,'0'
            mov bl,al
            mov al,dl
            mul byte [a]  ;we will try to built the number digit by digit
            add al,bl
            mov dl,al
            
            
            
            ; we will compare it with the ascii code of each of the characters a-z A-Z and 0-9
            
        loop Check
        
        inc_esi: ; we reached the end of the number
            inc esi ;we prepare for the next iteration
            mov al,dl
            stosb ; we will put the built number in our predefined array
            mov dl,0
            add [len_string], dword 1 ; we will use our variable len_string to keep count of the numbers of our array
            cmp ecx,0
            ja dec_ecx
            jmp Check
        
        dec_ecx:; we will pass the ',' and ' ' elements from our text
            dec ecx
            dec ecx 
            jmp Check
        
        continue:
            mov ecx,0
            mov ecx,[len_string]
            mov esi,string ; we save the beginning of our string
            lea edi,[esi+ecx-1] ; we save the ending value of our array
            jmp continue2
        
        continue2:
            mov al, [esi]
            mov bl, [edi]
            mov [edi],al
            mov [esi],bl  ; we will interchange the elements in our array
            inc esi
            dec edi
            cmp esi,edi ; we check if we interchanged all elements
            jb continue2 
        
        mov esi,string
        lea edi,[esi+ecx-1] 
        continue3: ; we will go through every element again
            mov al,[esi] ; we put the element in al
            push eax
            call Double ; we will double the element through our function
            mov [esi],al ; we put it in it's place
            inc esi
            cmp esi,edi ; we check if we did the same for every element
            jbe continue3
        
        
     final:
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        mov esi,string
        mov ebx,1
        afisare: ; we print each element to the console
            mov al,[esi]
            cbw
            cwde
            inc esi
            inc ebx
        
            push dword eax
            push dword format
            call [printf]
            add esp, 4*2
            cmp ebx,[len_string]
            jbe afisare
        ; exit(0)
        push dword 0
        call [exit]