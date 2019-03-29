.model small;
.stack 100h;
.data


tb1 db 13,10,'Nhap A: $';
tb2 db 13,10,'Nhap B: $';
tb3 db 13,10,'Nhap sai dieu kien (a,b < 100 & a<b) $';
tb4 db 13,10,'Tich 2 so la: $';

soA  dw  0
soB  dw  0


.code
main proc
    
    mov ax,@data;
    mov ds,ax;
    
    
    StartA:
    mov ah,09h;
    lea dx,tb1;
    int 21h;
    
    NhapA:
    mov ah,01h;
    int 21h;
    cmp al,13;
    JE KiemTraA;
    mov ah,0;
    sub al,30h;
    mov cx,ax;
    mov ax,soA;
    mov bx,10;
    mul bx;
    add ax,cx;
    mov soA,ax;
    JMP NhapA;
    
    KiemTraA:
    cmp soA,100;
    JA SaiA;
    JMP StartB;
    
    SaiA:
    mov ah,09h;
    lea dx,tb3;
    int 21h;
    mov soA,0;
    JMP StartA;
    
    
    StartB:
    mov ah,09h;
    lea dx,tb2;
    int 21h;
    
    NhapB:
    mov ah,01h;
    int 21h;
    cmp al,13;
    JE KiemTraB;
    mov ah,0;
    sub al,30h;
    mov cx,ax;
    mov ax,soB;
    mov bx,10;
    mul bx;
    add ax,cx;
    mov soB,ax;
    JMP NhapB;
    
    KiemTraB:
    cmp soB,100;
    JA SaiB;
    mov ax,soA;
    cmp soB,ax;
    JBE SaiB;
    JMP TinhTich:
    
    SaiB:
    mov ah,09h;
    lea dx,tb3;
    int 21h;
    mov soA,0;
    mov soB,0;
    JMP StartA;
    
    
    TinhTich:
    
    mov ah,09h;
    lea dx,tb4;
    int 21h;

    mov ax,soA;
    mov bx,soB;
    mul bx;

    mov bx,10;
    mov cx,0;
    mov dx,0;
    
    chia:
    div bx;
    push dx;
    inc cx;
    cmp ax,0
    JE HienKQ;
    xor dx,dx;
    JMP chia;
    
    
    HienKQ:
    pop dx;
    add dl,30h;
    mov ah,02h;
    int 21h;
    loop HienKQ;
    
    
    mov ah,4ch;
    int 21h;
    
main endp; 
end main;
     