.model small
.stack 100h
.data
; khai bao du lieu o day
tb db 'Mang so nguyen: $';
array db 1,2,3,4,5,6;


 
.code
main proc 
    ;---nen khai bao truoc o day nhu vay---;
    mov ax,@data
    mov ds,ax
    ;---nen khai bao truoc o day nhu vay---;

    mov ah,09h;
    lea dx,tb;
    int 21h;
    
    lea dx,array;tro dx toi dau mang array
    mov cx,6;lap 6 lan
    mov di,dx;di tro den dx (tro den dau mang)
    
    lap:
    mov dl,[di];dua gia tri cua o nho di vao dl
    or dl,30h;chuyen ky tu ascII sang so
    mov ah,02h;
    int 21h;
    inc di;tang di len o nho tiep theo (phan tu tiep theo cua mang)
    mov dl,' ';dl luc nay la dau cach;
    int 21h;
    loop lap


mov ah,4ch;ham ngat chuong trinh (thuong dat o cuoi chuong trinh)
int 21h
main endp
;Chuong trinh con se chua tai day
end main
