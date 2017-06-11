assume cs:code
codesg segment
start:
  mov ax,data
  mov ds,ax

  mov si,0
  mov ax,table
  mov es,ax         
  mov di,0
  mov bx,0
  mov cx,21

  s:mov ax,ds:[si]     ; 年份转送start
    mov es:[di],ax
    mov ax,ds:[si+2]
    mov es:[di+2],ax

    mov ax,ds:[si+84]    ; 收入转送
    mov es:[di+5],ax
    mov dx,ds:[si+84+2]   
    mov es:[di+7],dx

    push cx                 ;暂存循环次数
    mov cx,ds:[84+84+bx]    ;雇员数转送
    mov es:[di+0ah],cx      ;加0是因为处于文本编辑模式而非debug模式

    div cx                  ;计算人均收入，商在ax中                          
    pop cx                  ;回复循环次数

    mov es:[di+0dh],ax

    add si,4                ;年份和收入都是一次移动四个字节
    add bx,2                ;一个雇员两个字节
    add di,16

    loop s                  ;循环21次。

  mov ax,4c00h
  int 21h
codesg ends
end start
