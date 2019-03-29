.model small
.stack 100h
.data
    max EQU 100
    X DB 0
    Y DB 'Hello'
    Z DB 5 DUP(0)
    hoten db "Hello Assembly$"
    
    tb1 db "Hay nhap 1 ky tu: $"
    tb2 db "Ky tu da nhap:  $"
    mes1 db "Ky tu truoc ky tu da nhap: $"
    mes2 db "Ky tu sau ky tu da nhap: $"
    kytu db ?
    error db 'Ban nhap khong hop le $'
    
    
.code
main proc 
    ;---nen khai bao truoc o day nhu vay---;
    mov ax,@data
    mov ds,ax
    ;---nen khai bao truoc o day nhu vay---;
    
    
    @NewLine Macro
    mov ah,02h;
    mov dl,10d;
    int 21h;
    mov ah,02h;
    mov dl,13d;
    int 21h;
    endm


    start:
    @NewLine
  
    mov ah,09h
    lea dx,tb1
    int 21h
    
    mov ah,01h
    int 21h
    
    mov kytu,al; dua ky tu vua nhap vao bien kytu
    cmp kytu,41h;Chu A
    JB loinhap
    cmp kytu,7Ah;Chu z
    JA loinhap
    JMP next;
    
    
    loinhap:
    mov ah,09h;
    lea dx,error;
    int 21h;
    JMP start;
    
    
    
    next:
    @NewLine  
    mov ah,09h
    lea dx,tb2
    int 21h

    mov ah,02h
    mov dl,kytu
    int 21h
    
    
    
    ;hien thi ky tu truoc ky tu nhap
    @NewLine
    mov ah,09h
    lea dx,mes1
    int 21h
    
    mov ah,02h
    mov dl,kytu
    dec dl; lui ve sau 1 ky tu ( dl = dl - 1)
    int 21h
    
    
    
    ;hien thi ky tu sau ky tu nhap
    @NewLine
    mov ah,09h
    lea dx,mes2
    int 21h
    
    
    mov ah,02h
    mov dl,kytu
    inc dl; tang len 1 ky tu ( dl = dl + 1)
    int 21h
    
    
    


    mov ah,4ch
    int 21h
    
main endp
;Chuong trinh con se chua tai day
end main
