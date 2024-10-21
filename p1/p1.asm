; Nawadeep Khatri
;5086950
;oct 21
;Fibonnaci using index method
INCLUDE Irvine32.inc

.data
	arr DWORD 40 DUP (?) ; creates an array of size forty
	out_msg BYTE "Fibonacci number ", 0
	out_msg1 BYTE " = ", 0
	
.code
	main PROC
		mov edi, OFFSET arr ; starting location of array
		mov eax, 1          ; first Fibonacci number
		mov ebx, 1          ; second Fibonacci number
		mov esi, 0          ; index for the Fibonacci number (1-based)
		
	L1:
		mov edx, OFFSET out_msg 
		call WriteString     ; print the Fibonacci number message
	
		mov edx,eax
		
		mov eax, esi         ; load current index into edx
		call WriteDec        ; print the index number

		mov eax, edx
		
		mov edx, OFFSET out_msg1
		call WriteString     ; print the equals sign message
		
		mov [edi], eax       ; store current Fibonacci number (eax) in the array
		call WriteDec        ; print the Fibonacci number (eax)
		
		call Crlf            

		add edi, 4           ; move to the next location in arr

		; Calculate the next Fibonacci number
		mov ecx, eax         ; save the current value of eax into ecx
		mov eax, ebx         ; move the value of ebx to eax
		add ebx, ecx         ; calculate the next Fibonacci number (ebx)

		inc esi             		 ; increment the index
		cmp esi, 40         	 ; check if we have printed 20 numbers
		jl L1                			;	 loop if we have not reached 20

		exit
	main ENDP
END main
