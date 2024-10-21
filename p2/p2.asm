INCLUDE Irvine32.inc

.data
	arr DWORD 40 DUP (?) 							; creates an array of size forty
	out_msg BYTE "Fibonacci number ", 0 ; output message
	out_msg1 BYTE " = ", 0							; output message
	
.code
	main PROC
		mov edi, OFFSET arr ; starting location of array
		mov eax, 1          ; first Fibonacci number
		mov ebx, 1          ; second Fibonacci number
		mov esi, 0          ; index 
		
	L1:
		mov [edi], eax       ; store current Fibonacci number in the array		
		add edi, 4           	 ; move to the next location in array

		mov ecx, eax         ; save the current value of eax into ecx
		mov eax, ebx         ; move the value of ebx to eax
		add ebx, ecx          ; calculate the next Fibonacci number 

		inc esi             		 ; increment the index
		cmp esi, 40         	 ; check if we have printed 20 numbers
		jl L1                			 ;	exit loop if condition matches

		mov edi,OFFSET arr						; edi holds the address to the array
		mov esi,0											; counter initalization
		
	L2:
		
		mov edx, OFFSET out_msg			; edx hold memory address of msg
		call WriteString									; prints the message
		
		mov eax, esi										; move index to eax so we can print esi
		call WriteDec										; prints index
		
		mov edx, OFFSET out_msg1
		call WriteString									; prints the second msg
		
		mov eax,[edi]									; eax retrieves the value that edi points to
		call WriteDec										; prints the value in the array
		call Crlf												; line break
		add edi , 4											; move to the next element of the array
		
		inc esi												; increase the index 
		cmp esi , 40										; check if the condition
		jl L2														; exit loop if condition matches
		
		exit
	main ENDP
END main
