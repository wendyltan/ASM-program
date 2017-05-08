assume cs:code,ds:data

data segment
    db 'welcome to masm!'			;0~15
    db 00000010b           ;绿字     ;16
    db 00100100b           ;绿底红字  ;17
    db 01110001b           ;白底蓝字   ;18
data ends

stack segment
	db 16 dup(0)
stack ends

code segment
	start:
		mov ax,data
		mov ds,ax

		mov ax,stack
		mov ss,ax
		mov sp,10h

		mov ax,0b800h				;移到那段内存空间	
		mov es,ax

		mov bp,16					;用bp定位色彩属性串
		mov bx,0680h				;bx定位行起始位置

		mov cx,3
	s:
			push cx					;暂存cx
			mov si,0
			mov di,0
			mov cx,16           	;循环16次
		s1:
			mov al,ds:[si]			;低位放字符串
			mov ah,ds:[bp]   		;高位放色彩信息
			mov es:[bx+di],ax		;转移到内存空间中
			inc si				
			add di,2				;每次前进两位（存放了一个字内容）
		loop s1				
			
			inc bp
			add bx,0a0h				;去到下一行起始位置
			pop cx			
	loop s		


	mov ax,4c00h
	int 21h               
code ends
end start



	