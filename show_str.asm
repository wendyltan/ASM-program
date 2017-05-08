assume cs:code
data segment 
    db 'Welcome to masm!',0
data ends

code segment 
    start:  
    		mov dh,8
            mov dl,3
            mov cl,2   ;green color is 00000010b


            mov ax,data
            mov ds,ax              
            mov si,0
            call show_str
            
            mov ax,4c00h
            int 21h
    show_str:

           push ax
           push cx
           push bx
            
            mov ax,0b800h                ;������ָ��dh��dl����ʾ
            mov es,ax
            dec dh
            mov al,160
            mul dh
            push ax                      ;���㱣���е�ַ
            mov al,2
            mul dl                        ;�����е�ַ
            pop di
            add di,ax                     ;ʹ���ֽ�����λ�˼��м���

            ; add dl,dl
            ; mov dh,0
            ; add ax,dx
            ; mov di,ax

            mov bx,cx						;store color in bx
            
            print:  
            		mov cx,ds:[si]         ;while it was not at the end of the string'0',move in to es:[di]
                    jcxz print_end
                    mov es:[di],cx
                    inc si
                    inc di
                    mov byte ptr es:[di],bl  ;������ɫ,green bk and red text
                    inc di
                    jmp short print
            print_end:          
            		pop bx
            		pop cx
                    pop ax
                    
                    ret
            
code ends
end start



