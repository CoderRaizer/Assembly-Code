.model small
.stack 100h
.data
; khai bao du lieu o day        
tb1 db 'Nhap a: $'
tb2 db 'Nhap b: $'
tb3 db 'Nhap Sai-Nhap Lai $'
tb4 db 'Tong La: $'


soA dw 0
soB dw 0
tong dw 0

;// tinh tong 2 so a va b, biet a <= 50 va b <= 100;
.code
main proc 
    ;---nen khai bao truoc o day nhu vay---;
    mov ax,@data
    mov ds,ax
    ;---nen khai bao truoc o day nhu vay---;

    NewLine Macro
    mov ah,02h
    mov dl,13
    int 21h
    mov ah,02h
    mov dl,10
    int 21h
    endm
    
    
    ;---------A---------;
    StartA:
    NewLine
    mov ah,09h;
    lea dx,tb1;
    int 21h;
    
    NhapA:
    mov ah,01h;
    int 21h;
    cmp al,13
    JE KiemTraA
    mov ah,0;
    sub al,30h;chuyen thanh so
    mov cx,ax;chuyen so vua nhap vao cx
    mov ax,soA;chuyen gia tri soA vao ax
    mov bx,10;gan bx = 10
    mul bx;nhan ax cho 10
    add ax,cx;
    mov soA,ax;
    JMP NhapA;
    
    KiemTraA:
    cmp soA,50;
    JA SaiA;
    JMP StartB; 
    
    SaiA:
    NewLine
    mov ah,09h;
    lea dx,tb3;
    int 21h;
    mov soA,0;
    JMP StartA;
    
    ;---------B---------;
    StartB:
    NewLine
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
    JMP TinhTong;
     
    SaiB:
    NewLine
    mov ah,09h;
    lea dx,tb3;
    int 21h;
    mov soB,0;
    JMP StartB
    
    
    ;---------SUM---------;
    TinhTong:
    NewLine
    
    mov ah,09h;
    lea dx,tb4;
    int 21h;
    

    mov ax,soA;
    mov bx,soB;
    add ax,bx;

     
    mov bx,10;
    mov cx,0; bien dem cua vong lap
    mov dx,0;
    
    
    chia:
    div bx;lay tong trong ax / 10
    push dx;du o dx day vao stack
    inc cx;
    cmp ax,0;so sanh thuong voi 0
    JE HienKQ
    xor dx,dx;xoa bit cao trong dx
    JMP chia
    
    HienKQ:
    pop dx;lay du trong stack ra khoi dx
    add dl,30h;chuyen so thanh ky tu
    mov ah,02h;
    int 21h;
    loop HienKQ;


mov ah,4ch;ham ngat chuong trinh (thuong dat o cuoi chuong trinh)
int 21h
main endp
;Chuong trinh con se chua tai day
end main
