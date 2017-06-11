;p228统计data段数值为8的字节个数，ax保存结果
assume cs:code

data segment
	db 8,11,8,1,8,5,63,38
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov bx,0

	mov ax,0	;ax as a counter for counting '8'
	mov cx,8
s:
	cmp byte ptr [bx],8
	jne next
	inc ax
next:
	inc bx
	loop s

	mov cx,4c00h
	int 21h

code ends
end start