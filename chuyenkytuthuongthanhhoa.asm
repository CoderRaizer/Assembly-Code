.model small
.stack 100h
.data
; khai bao du lieu o day
    title1 db "Nhap 1 ky tu thuong: $";
    title2 db "Nhap sai (Nhap lai)$";
    title3 db "Ket qua chuyen thanh ky tu Hoa: $";
    kytu DB ?,'$'
  
.code
main proc 
    ;---nen khai bao truoc o day nhu vay---;
    mov ax,@data
    mov ds,ax
    ;---nen khai bao truoc o day nhu vay---;
    
    @NewLine Macro
    mov dl,10;
    mov ah,02h;
    int 21h;
    mov dl,13d;
    mov ah,02h;
    int 21h;
    endM
    
    mov ah,09h;
    lea dx,title1;
    int 21h;
    
    
    start:
    mov ah,01h;cho phep nhap - SAU LENH NAY THI MA ASCII SE CHUA TRONG AL
    int 21h;
    cmp al,61h;
    JB nhaplai;nho hon hoac bang ky tu a dau tien trong bang ma
    cmp al,7ah
    JA nhaplai;lon hon hoac bang ky tu z cuoi cung trong bang ma
    JMP convert
    
    nhaplai:
    @NewLine
    mov ah,09h;
    lea dx,title2;
    int 21h;
    JMP start; 
    
    
    convert:
    @NewLine
    sub al,20h;
    mov kytu,al;
    mov ah,09h;
    lea dx,title3;
    int 21h;
    mov ah,02h;
    mov dl,kytu;
    int 21h;
    
    

    mov ah,4ch
    int 21h
main endp
;Chuong trinh con se chua tai day
end main