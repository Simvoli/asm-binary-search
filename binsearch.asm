IDEAL
MODEL small
STACK 100h
DATASEG
	array db -3, -1, 0, 2, 5
	len dw 5
	result dw ?
CODESEG
start:
	mov ax, @data
	mov ds, ax  
	push [len]              ; length
	push offset array       ; offset of array
	push offset result      ; result pointer
	push 2                  ; num to search
	call BinarySearchH
	
exit:
	mov ax, 4c00h
	int 21h

proc BinarySearchH
	push bp
	mov bp, sp
	push si
	push ax
	push bx
	push cx
	push dx
	push di
	
	mov cx, [bp+4]          ; num to search
	mov bx, [bp+8]          ; offset of the array (left)
	mov ax, [bp+10]         ; length
	add ax, bx
	dec ax                  ; right = offset + length - 1
	mov dx, bx              ; save start of the array
	call BinarySearch
	mov si, [bp+6]          ; result pointer
	mov [si], di
	
	pop di
	pop dx
	pop cx
	pop bx
	pop ax
	pop si
	pop bp
	ret 8
endp

proc BinarySearch
	cmp bx, ax             ; compare left and right
	ja notFound             ; if left > right, not found
	
	; mid = left + (right - left) / 2
	mov di, ax
	sub di, bx
	shr di, 1
	add di, bx
	
	cmp [di], cl
	je Found
	jl Lower
	
	; array[mid] > target, search left half
	dec di
	mov ax, di
	jmp BinarySearch

Lower:
	; array[mid] < target, search right half
	inc di
	mov bx, di
	jmp BinarySearch

Found:
	sub di, dx              ; index = mid - start of array
	ret
	
notFound:
	mov di, 0FFh
	ret
endp

END start
