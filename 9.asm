assume cs:code

data segment
	db "welcome to masm! ",0
data ends

code segment
start:
	 ;安装中断例程
	 mov ax,cs
	 mov ds,ax
	 mov si,offset show0

	 mov ax,0
	 mov es,ax
	 mov di,200h

	 mov cx,offset show0end-offset show0
	 cld
	 rep movsb

	 ;存入中断向量表
	 mov word ptr es:[7ch*4],200h
	 mov word ptr es:[7ch*4+2],0

	 ;测试中断例程
	 mov dh,10
	 mov dl,10
	 mov cl,2
	 mov ax,data
	 mov ds,ax
	 mov si,0
	 int 7ch
	 mov ax,4c00h
	 int 21h

	 

	show0:

		;设置显示区
		mov ax,0b800h
		mov es,ax
		
		mov al,160
		mul dh
		add dl,dl
		mov dh,0

		add ax,dx
		mov di,ax


		loop1:
			;移动字符到显示区
			 mov al,ds:[si]
			 mov ah,0
			 cmp ax,0
			 je operate1
			 mov ah,cl
			 mov es:[di],ax
			 inc si
			 add di,2
			 jmp loop1

		operate1:
			 iret
	show0end:nop


code ends
end start





