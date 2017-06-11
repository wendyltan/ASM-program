;p221将两个128位数据相加
assume cs:code
code segment
start:
	

	add128:
		push ax
		push cx
		push si
		push di

		sub ax,ax;cx设置为0

		mov cx,8
	s:
		mov ax,[si]
		adc ax,[di]
		mov [si],ax
		inc si
		inc si
		inc di
		inc di
		loop s

		pop di
		pop si
		pop cx
		pop ax
		ret
	

code ends
end start