;p260在5行12列显示三个红底高亮闪烁绿色的a
assume cs:code
code segment
start:
	
	;置光标
	mov ah,2
	mov bh,0
	mov dh,5
	mov dl,12
	int 10h

	;光标处显示字符
	mov ah,9
	mov al,'a'
	mov bl,11001010b
	mov bh,0
	mov cx,3
	int 10h

	mov ax,4c00h
	int 21h

code ends
end start