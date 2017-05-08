assume cs:code

code segment 
    start:    
            mov ax,4240H
            mov dx,000FH
            mov cx,0AH
            call divdw
            
            mov ax,4c00h
            int 21h
    ;----------------------------------
    divdw:    
            push bx        ;保存bx内容
            push ax        ;保存低16位
            mov ax,dx       ;高十六位移到ax
            mov dx,0        
            div cx         
            pop bx        ;取出低16位
            push ax        ;保存高16位结果
            
            mov ax,bx       ;低十六位除法
            div cx        
            mov cx,dx    ;cx保存余数
            pop dx        ;取出高16位结果
    divdw_end:
            pop bx
            ret
    ;-----------------------------------
            
code ends
end start


