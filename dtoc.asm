assume cs:code

data segment 
    db 20 dup(0)
data ends


code segment 
    start:
            mov ax,data
            mov ds,ax
            mov ax,12666
            mov si,0
            call dtoc

            mov dh,8
            mov dl,3
            mov cl,2
            call show_str

            mov ax,4c00h
            int 21h

    ;---------------------------------
    dtoc:
            push ax
            push bx
            push cx
            push dx
            push si
            mov bx,0
        x:  
            mov dx,0      ;��0
            mov cx,10     ;����10
            div cx        
            mov cx,ax     ;ͨ��cx�ж��Ƿ���0����ѭ��
            add dx,30h     ;������������30hת��Ϊ��Ӧ��ASCII��
            push dx         ;����������ѹջ
            inc bx
            jcxz f
            jmp x
        f:  
            mov cx,bx       ;�洢ѭ������
        x1:
            pop ds:[si]      ;��ʮ�����ַ�ѹջֵ���������ݶ��ڴ�ռ�
            inc si
            loop x1

            pop si
            pop dx
            pop cx
            pop bx
            pop ax
            ret

     ;---------------------------------       
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

            mov bx,cx                       ;store color in bx
            
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
    ;----------------------------------
                    
        
code ends
end start


