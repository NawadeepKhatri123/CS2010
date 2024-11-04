
INCLUDE Irvine32.inc

.data
    sorted BYTE 2, 5, 9, 11, 23, 41, 57, 68, 71, 82, 85
    arraySize BYTE 11
    promptInput BYTE "Which location do you wish to change (0-10): ", 0
    promptValue BYTE "Enter the new value: ", 0

.code
main PROC
    ; Print the initial array
    call PrintArray

    ; Prompt user for location to change
    WriteString promptInput
    ReadInt eax               ; Read input location into eax
    mov ecx, eax              ; Store location in ecx

    ; Prompt user for new value
    WriteString promptValue
    ReadInt eax               ; Read new value into eax
    mov bl, al                ; Store new value in bl

    ; Shift elements to the right
    call ShiftElements

    ; Insert the new value
    mov sorted[ecx], bl

    ; Print the updated array
    call PrintArray

    ; Exit program
    exit
main ENDP

; Procedure to print the array
PrintArray PROC
    mov ecx, 0                 ; Index
    .PrintLoop:
        mov al, sorted[ecx]   ; Load element into al
        WriteDec al           ; Print element
        call Crlf             ; New line
        inc ecx
        cmp ecx, arraySize
        jl .PrintLoop
    ret
PrintArray ENDP

; Procedure to shift elements to the right
ShiftElements PROC
    mov ecx, arraySize - 1     ; Start from the end
    mov edx, ecx                ; edx holds the index of the last element
    mov eax, ecx                ; eax will be used to compare with insertion index

    ; Shift elements right
    .ShiftLoop:
        cmp eax, ecx            ; Compare current index with insertion index
        jle .EndShift           ; If eax <= ecx, we are done
        mov al, sorted[eax]     ; Load element to be shiftedINCLUDE Irvine32.inc

.data
    sorted BYTE 2, 5, 9, 11, 23, 41, 57, 68, 71, 82, 85
    arraySize BYTE 11
    promptInput BYTE "Which location do you wish to change (0-10): ", 0
    promptValue BYTE "Enter the new value: ", 0

.code
main PROC
    ; Print the initial array
    call PrintArray

    ; Prompt user for location to change
    WriteString promptInput
    ReadInt eax               ; Read input location into eax
    mov ecx, eax              ; Store location in ecx

    ; Validate input location
    cmp ecx, 0
    jl InvalidLocation        ; If less than 0, go to invalid
    cmp ecx, arraySize
    jge InvalidLocation       ; If greater than or equal to size, go to invalid

    ; Prompt user for new value
    WriteString promptValue
    ReadInt eax               ; Read new value into eax
    mov bl, al                ; Store new value in bl

    ; Shift elements to the right
    call ShiftElements

    ; Insert the new value
    mov sorted[ecx], bl

    ; Print the updated array
    call PrintArray

    ; Exit program
    exit

InvalidLocation:
    WriteString "Invalid location. Please enter a number between 0 and 10.", 0
    exit

main ENDP

; Procedure to print the array
PrintArray PROC
    mov ecx, 0                 ; Index
    .PrintLoop:
        mov al, sorted[ecx]   ; Load element into al
        WriteDec al           ; Print element
        call Crlf             ; New line
        inc ecx
        cmp ecx, arraySize
        jl .PrintLoop
    ret
PrintArray ENDP

; Procedure to shift elements to the right
ShiftElements PROC
    mov ecx, arraySize - 1     ; Start from the last element
    mov edx, ecx                ; edx holds the index of the last element

    ; Shift elements right
    .ShiftLoop:
        cmp ecx, 0            ; Check if ecx is 0
        je .EndShift          ; If ecx is 0, we're done
        mov al, sorted[ecx]   ; Load element to be shifted
        mov sorted[edx], al    ; Move element to the right
        dec ecx               ; Decrement ecx (current index)
        dec edx               ; Decrement edx (destination index)
        jmp .ShiftLoop

    .EndShift:
    ret
ShiftElements ENDP

END main

        mov sorted[edx], al     ; Move element to the right
        dec eax
        dec edx
        jmp .ShiftLoop

    .EndShift:
    ret
ShiftElements ENDP

END main
