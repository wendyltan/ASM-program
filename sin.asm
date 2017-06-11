assume cs:code
code segment
start:
	mov ax,30
	call showsin

	mov ax,4c00h
	int 21h

showsin: 
	jmp short show

	table dw ag0,ag30,ag60,ag90,ag120,ag150,ag180
	ag0 db '0',0
	ag30 db '0.5',0
	ag60 db '0.866',0
	ag90 db '1',0
	ag120 db '0.866',0
	ag150 db '0.5',0
	ag180 db '0',0

show:
	push bx
	push es
	push si
	mov bx,0b800h
	mov es,bx

	;通过角度计算table表偏移
	mov ah,0
	mov bl,30
	div bl
	mov bl,al
	mov bh,0            ;防止高位乱七八糟
	add bx,bx
	mov bx,table[bx]

	mov si,160*12+40*2	;显示在屏幕中间
shows:
	mov ah,cs:[bx]
	cmp ah,0		;判断字符串结尾
	je showret
	mov es:[si],ah	;显存中显示结果
	inc bx
	add si,2
	jmp short shows
showret:
	pop si
	pop es
	pop bx
	ret

code ends
end start
