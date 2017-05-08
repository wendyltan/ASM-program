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
            mov dx,0      ;置0
            mov cx,10     ;除数10
            div cx        
            mov cx,ax     ;通过cx判断是否商0结束循环
            add dx,30h     ;若有余数，加30h转化为对应的ASCII码
            push dx         ;保存余数，压栈
            inc bx
            jcxz f
            jmp x
        f:  
            mov cx,bx       ;存储循环次数
        x1:
            pop ds:[si]      ;把十进制字符压栈值弹出到数据段内存空间
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


            
            mov ax,0b800h                ;设置在指定dh行dl列显示
            mov es,ax
            dec dh
            mov al,160
            mul dh
            push ax                      ;计算保存行地址
            mov al,2
            mul dl                        ;计算列地址
            pop di
            add di,ax                     ;使用字节数定位了几行几列

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
            mov byte ptr es:[di],bl  ;设置颜色,green bk and red text
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


