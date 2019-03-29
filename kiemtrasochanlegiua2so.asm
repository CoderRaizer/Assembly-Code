.model small
.stack 100h
.data

tb1 db 13,10,'Nhap So (so > 0 && so < 100): $'
tb2 db 13,10,'$Nhap Khong Hop Le (Nhap Lai)'
tb3 db 13,10,'La So Chan! $'
tb4 db 13,10,'La So Le! $'


so dw 0

.code
main proc
    
    mov ax,@data
    mov ds,ax
    
    Start:
    mov ah,09h
    lea dx,tb1
    int 21h
    
    
    NhapSo:
    mov ah,01h
    int 21h
    cmp al,13
    JE KiemTra
    ;-- Kiem tra nhap co phai la so khong
    cmp al,30h
    JB Sai
    cmp al,39h
    JA Sai
    ;-- Kiem tra nhap co phai la so khong
    mov ah,0
    sub al,30h
    mov cx,ax
    mov ax,so
    mov bx,10
    mul bx
    add ax,cx
    mov so,ax
    JMP NhapSo
    
    
    KiemTra:

    cmp so,100 ;- so < 100 -> phu dinh: lon hon hoac bang thi sai
    JAE Sai
    JMP XacThuc
    
    
    Sai:
    mov ah,09h
    lea dx,tb2
    int 21h
    mov so,0
    JMP Start
    
    
    
    XacThuc:

    mov ax,so
    mov bl,2 
    mov ah,0 ;- xoa bit cao , du se luu o ah
    div bl   ;- chia ax cho 2
    
    cmp ah,0 
    JE sochan
    cmp ah,0
    JNE sole
    
    sochan:
    mov ah,09h
    lea dx,tb3
    int 21h
    JMP exit
    
    sole:
    mov ah,09h
    lea dx,tb4
    int 21h
    JMP exit

    exit:
    mov so,0;
    JMP Start;
    
    
    mov ah,4ch;
    int 21h;
    
    main endp
    end main
    
    
    