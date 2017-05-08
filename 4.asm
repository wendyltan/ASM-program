assume cs:codesg
data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995'
;年份
  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
;公司总收入
  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
;公司雇员人数
data ends

table segment
 db 21 dup('year summ ne ?? ')
table ends

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
