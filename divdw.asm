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
            push bx        ;����bx����
            push ax        ;�����16λ
            mov ax,dx       ;��ʮ��λ�Ƶ�ax
            mov dx,0        
            div cx         
            pop bx        ;ȡ����16λ
            push ax        ;�����16λ���
            
            mov ax,bx       ;��ʮ��λ����
            div cx        
            mov cx,dx    ;cx��������
            pop dx        ;ȡ����16λ���
    divdw_end:
            pop bx
            ret
    ;-----------------------------------
            
code ends
end start


