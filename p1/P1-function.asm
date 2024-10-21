; Nawadeep Khatri
;5086950
;oct 21
;Fibonnaci using index method and using a function/method

INCLUDE Irvine32.inc

.data
    arr DWORD 40 DUP (?)                       ; creates an array of size forty
    out_msg BYTE "Fibonacci number  ", 0      ; message to print before number
    out_msg1 BYTE " = ", 0                      ; message for equal sign

.code
main PROC
    mov edi, OFFSET arr                        ; edi points to start of array
    mov ecx, 1                                 ; first Fibonacci number (1)
    mov ebx, 1                                 ; second Fibonacci number (1)
    mov esi, 0                                 ; counter for how many numbers stored

L1:    
    mov [edi], ecx                             ; store current number in array
    mov eax, ecx                               ; move number to eax to print
    call Print                                 ; call Print to show number
    
    add edi, 4                                 ; go to next array element
    inc esi                                    ; increase counter

    mov [edi], ebx                             ; store next number in array
    mov eax, ebx                               ; move next number to eax to print
    call Print                                 ; call Print to show number
    
    add ecx, ebx                               ; calculate next Fibonacci number
    add ebx, ecx                               ; update second last number

    add edi, 4                                 ; go to next array element
    inc esi                                    ; increase counter
    cmp esi, 40                                ; check if 40 numbers are stored
    jl L1                                      ; if not, go back to L1
    
    exit                                       ; exit program
main ENDP

Print PROC
    
    mov edx, OFFSET out_msg                   ; load message into edx
    call WriteString                           ; print "Fibonacci number"
    
    xchg eax, esi                              ; swap eax and esi 
    call WriteDec                              ; print current Fibonacci number
    xchg eax, esi                              ; get back eax from esi
    
    mov edx, OFFSET out_msg1                  ; load "=" message into edx
    call WriteString                           ; print "="
    
    mov edx, eax                               ; move last number into edx for printing
    call WriteDec                              ; print last Fibonacci number
    call Crlf                                  ; go to new line
    ret                                         ; return from Print procedure
    

Print ENDP

END main
