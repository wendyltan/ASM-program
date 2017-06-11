assume cs:code
code segment
start:
	 
	 mov bp,160*12
	 mov si,30*2

	 ;hour
	 mov al,4
	 out 70h,al
	 in al,71h
	 call deal	 
	 call show
	 call show_colon
	 add si,6


	 ;minute
	 mov al,2
	 out 70h,al
	 in al,71h
	 call deal	 
	 call show
	 call show_colon
	 add si,6


	 ;second
	 mov al,0
	 out 70h,al
	 in al,71h
	 call deal	 
	 call show

deal:

	 mov ah,al
	 mov cl,4
	 shr ah,cl
	 and al,00001111b
	 add ah,30h
	 add al,30h
deal_end:
	ret

show:

	 mov bx,0b800h
	 mov es,bx
	 mov byte ptr es:[bp+si],ah
	 mov byte ptr es:[bp+si+2],al
show_end:
	 ret 
	 
show_colon:
	 mov dl,':'
	 mov byte ptr es:[bp+si+4],dl
	 ret


code ends
end start
