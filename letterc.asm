;将以0结尾的字符串中的字符小写字母变成大写字母
assume cs:codesg
datasg segment
  db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends
codesg segment
begin: 
      mov ax,datasg
      mov ds,ax
      mov si,0
      call letterc
      
      mov ax,4c00h
      int 21h
letterc: 
      push si
      push cx
      mov cl,[si]
      cmp cl,0
      je ok
      cmp cl,'a'
      jb no
      cmp cl,'z'
      ja no
      and cl,11011111b
      mov [si],cl
    no:
       inc si
       jmp short letterc

    ok:
      pop cx
      pop si 
      ret  
              
codesg ends
end begin
