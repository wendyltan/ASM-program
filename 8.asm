assume cs:code
code segment
start:
	  mov ax,cs
	  mov ds,ax

	  ;传送源地址
	  mov si,offset do0
	  
	  ;传送目的地址0:200
	  mov ax,0	  
	  mov es,ax
	  mov di,200h
	  ;设置传输长度
	  mov cx,offset do0end-offset do0
	  ;设置传输方向为正
	  cld
	  rep movsb

	  ;0号表项存放偏移地址和段地址
	  mov word ptr es:[0],200h
	  mov word ptr es:[2],0

	  ;test
 	  mov dx,0ffffh
      mov bx,1
      div bx

	  mov ax,4c00h
	  int 21h

	do0:
		jmp short do0start
		db "divide error!"

	do0start:
		mov ax,cs
		mov ds,ax
		;第二句所在位置是202
		mov si,202h

		mov ax,0b800h
		mov es,ax
		mov di,11*160+30*2

		mov cx,13
	s:
		mov al,[si]
		mov es:[di],al
		inc si
		add di,2
		loop s

		mov ax,4c00h
		int 21h

	do0end:
		nop

code ends
end start

		
	


