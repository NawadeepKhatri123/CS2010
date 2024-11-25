; Nawadeep khatri
; Assignment 5
; 5086950

INCLUDE Irvine32.inc
.data
    ball BYTE '@'
    space BYTE ' '
    pos1 BYTE 40               
    dir BYTE 1                 
    block BYTE 219            
    leftBound BYTE 0          
    rightBound BYTE 79        
    bounces DWORD 0           
    scoreMsg BYTE "Bounces: ", 0
    gameOverMsg BYTE "Game Over! Final Score: ", 0
    row BYTE 7          
    paused BYTE 0
	level BYTE " Level :",13,10,"> Easy",13,10,"> Medium",13,10,"> Hard",0
	point_bank WORD 300
	points BYTE " Points :",0
	perfect1 BYTE 1
	perfect2 BYTE 1
.code
main PROC
mov edx, OFFSET level
	call WriteString
	mov dl, 0
	mov dh , 1
	call Gotoxy
	mov bh, 1
	
	L1:
		cmp al, 0Dh
		je equal
		cmp ah , 48h
		je move_Up
		call key_arrow
		cmp al, 0Dh
		je equal
		cmp ah , 48h
		je move_Up
		jmp L1
	
	move_Up:
	
		cmp bh, 1
		je back
		dec bh
		mov dl,0
		mov dh, bh
		call Gotoxy
		jmp L1
		
	equal:
		call Clrscr
		
	
    
gameLoop:
    ; Display score
	
    mov dl, 0
    mov dh, 0
    call Gotoxy
    mov edx, OFFSET points
    call WriteString
	mov eax, bounces
	call WriteDec
	
	mov dl, 0
    mov dh, 2
    call Gotoxy
    mov edx, OFFSET scoreMsg
    call WriteString
    mov ax,point_bank
    call WriteDec
    
    ; Display pause status if paused
    cmp paused, 1
    jne notPaused
   
notPaused:
    
    mov dl, leftBound
    mov dh, row
    call Gotoxy
    mov al, block
    call WriteChar
    mov dl, rightBound
    mov dh, row
    call Gotoxy
    mov al, block
    call WriteChar
    
    ; Move ball to current position
    mov dl, pos1
    mov dh, row
    call Gotoxy
    mov al, ball
    call WriteChar
    
    ; Check for boundary collision
    mov al, pos1
    cmp al, leftBound
    je gameOver
    cmp al, rightBound
    je gameOver
    
    ; Delay for visibility
    mov eax, 100
    call Delay
    
    ; Check for key press
    call ReadKey
    jz checkPauseAndMove    ; If no key, check pause status before moving
    
    ; Check specific keys
    cmp al, 'a'            ; Left key
    je checkLeftBounce
    cmp al, 'l'            ; Right key
    je checkRightBounce
	cmp al, 1Bh
	je gameOver			; esc key
    cmp al, ' '            ; Space key
    je togglePause
    jmp checkPauseAndMove

togglePause:
    xor paused, 1          ; Toggle pause state
    jmp gameLoop           ; Return to start of loop

checkPauseAndMove:
    cmp paused, 1          ; Check if game is paused
    je gameLoop            ; If paused, skip movement
    jmp moveBall           ; If not paused, continue with movement
    
checkLeftBounce:
    cmp dir, 1             ; Only reverse if moving right
    jne checkPauseAndMove
    ; Set new right boundary if not perfect bounce
    mov al, pos1
    mov bl, rightBound
    dec bl
    cmp al, bl
    je perfectBounce
	
	mov dl, bl
	sub dl, al
	movzx dx, dl
	sub point_bank, dx	; calc points
	
    mov rightBound, al     ; Set new boundary
    ; Display new boundary marker
    mov dl, al
    mov dh, row
    call Gotoxy
    mov al, block
    call WriteChar
	
	
	
	
perfectBounce:
    mov dir, -1           
    inc bounces
	cmp al,bl
	je twoline

    jmp checkPauseAndMove

checkRightBounce:
    cmp dir, -1            
    jne checkPauseAndMove
    mov al, pos1
    mov bl, leftBound
    inc bl
    cmp al, bl
    je perfectBounceLeft
	
	mov dl, al
	sub dl, bl
	movzx dx, dl
	sub point_bank, dx ; dec point bank
	
    mov leftBound, al      ; Set new boundary
    ; Display new boundary marker
    mov dl, al
    mov dh, row
    call Gotoxy
    mov al, block
    call WriteChar
    
perfectBounceLeft:
    mov dir, 1             
    inc bounces   
	cmp al,bl
	je twoline
    jmp checkPauseAndMove
    
moveBall:
    mov dl, pos1
    mov dh, row
    call Gotoxy
    mov al, space
    call WriteChar
    mov al, pos1
    add al, dir
    mov pos1, al
    jmp gameLoop


	
key_arrow:

	call ReadKey
	;cmp ah , 48h
	;je move_Up
	cmp ah, 50h
	je move_Down
	ret
	


move_Down:
	
	cmp bh, 3
	je back
	inc bh
	mov dl,0
	mov dh, bh
	call Gotoxy
	
	ret

back:
	ret
	
twoline:
	mov bl,dh
	sub dh, perfect1 
	call Gotoxy
	mov al, block
	call WriteChar
	mov dh, bl
	jmp checkPauseAndMove
	
gameOver:
    mov dl, 0
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET gameOverMsg
    call WriteString
    mov eax, bounces
    call WriteDec
    call Crlf
    call WaitMsg
	
    exit
main ENDP
END main
