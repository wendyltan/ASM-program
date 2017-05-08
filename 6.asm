assume cs:codesg
codesg segment
	mov ax,4c00h
	int 21h
start:mov ax,0
	s:nop				;0008
	  nop
	  mov di,offset s   ;mov di,0008
	  mov si,offset s2  ;mov si,0020

	  ;swapping s and s2
	  mov ax,cs:[si]     ;mov ax,cs:0020
	  mov cs:[di],ax     ;mov cs:0008,ax

	 s0:jmp short s      ;0016/jmp 0008/0008 has changed to s2/jmp to s2

	 s1:mov ax,0         ;0018
	    int 21h
	    mov ax,0

	 s2:jmp short s1     ;0020/jmp 0018/
	    nop
codesg ends
end start