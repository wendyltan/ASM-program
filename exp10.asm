;包含三个子程序：show_str,dtoc,divdw,功能见书p206
assume cs:code

data segment
    db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
    db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
    db '1993','1994','1995'

    dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
    dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

    dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
    dw 11542,14430,15257,17800
data ends

temp segment
    db 10 dup(0)
temp ends

stack segment
    db 64 dup(0)
stack ends

code segment
    start:
        mov ax,stack
        mov ss,ax
        mov sp,64

        mov ax,data
        mov es,ax
        mov ax,temp
        mov ds,ax

        mov si,0
        mov bp,0
        mov bx,0
        mov di,0

        mov cx,21                   ;循环21次
    s:  push cx
        
        ;存储显示年份
        mov ax,es:[bx]           
        mov ds:[si],ax
        mov ax,es:[bx+2]
        mov ds:[si+2],ax
        mov byte ptr ds:[si+4],0

        mov dh,24
        sub dh,cl                ;set row 3;
        mov dl,3                 ;set col 3;
        mov cl,2                 ;set color green.
        call show_str

        ;存储显示工资
        push dx                   ;store dx before using it
        mov ax,es:[84+bp]         ;store the low positon of the number
        mov dx,es:[84+bp+2]      ;store the high positon of the number
        call dtoc
        pop dx                    ;restore dx after using it
        add dl,10
        call show_str             

        ;存储显示雇员数
        push dx
        mov ax,es:[168+di]
        mov dx,0
        call dtoc
        pop dx
        add dl,10
        call show_str

        ;计算人均收入并存储显示
        push dx
        push cx
        mov ax,es:[84+bp]
        mov dx,es:[84+bp+2]
        mov cx,es:[168+di]
        call divdw
        call dtoc
        pop cx
        pop dx
        add dl,10
        call show_str

        add bx,4      ;4 bytes a year
        add bp,4      ;4 bytes a salary
        add di,2      ;2 bytes an employee

        pop cx    
    loop s

    mov ax,4c00h
    int 21h

    show_str:
        push ax
        push bx
        push cx
        push si
        push di
        push es

        mov bl,cl     ;颜色值暂存到bl
        mov bh,0

        mov ax,0b800h
        mov es,ax
        mov al,160    ;或者0a0h
        mov ah,0
        mul dh
        
        mov di,ax     ;存储当前行
        mov al,2
        mov ah,0
        mul dl
        
        add di,ax     ;存放当前精确位置

        write_str:
            mov ch,0
            mov cl,[si]    ;直到字符串以0结尾
            jcxz ok
            
            mov es:[di],cl    ;低位存放字符
            mov es:[di+1],bl  ;高位存放颜色值
            inc si
            add di,2
            jmp short write_str
        ok:
            pop es
            pop di
            pop si
            pop cx
            pop bx
            pop ax
            ret


    divdw:
        push bx
        push ax
        
        mov ax,dx
        mov dx,0      ;高十六位先进行除法
        div cx        ;结果放在ax中，如果有余数放在dx中
        
        mov bx,ax     ;结果暂存到bx中
        pop ax        ;恢复低十六位

        div cx        ;低十六位除法，结果存到ax返回
        mov cx,dx     ;如有余数，存放到cx返回
        mov dx,bx     ;高十六位结果存到dx返回

        pop bx
        ret

    dtoc:
        push bx
        push cx
        push si

        mov cx,0
        push cx
        mov bx,1
        div_continue:
            mov cx,10      ;存放除数
            call divdw     ;得到余数cx
            add cx,30H     ;得到余数相应的十进制字符码
            push cx        ;压栈暂存
            inc bx

            ;高低十六位都等于0，商就等于0
            mov cx,dx
            jcxz hzero     ;当cx等于0，跳转到hzero
            jmp short div_continue    ;执行循环
            hzero:
                mov cx,ax    ;结果低16位给cx
                jcxz lzero   ;当cx等于0，跳转到lzero
                jmp short div_continue    ;执行循环
            lzero:
                mov cx,bx     ;循环次数给cx，知道压栈了多少次，有多少个字符
            s_move:
                pop bx         ;压栈字符弹出
                mov ds:[si],bx  ;存放到内存空间
                inc si
                loop s_move

            pop si
            pop cx
            pop bx
            ret

code ends
end start
