.model tiny
.stack 100h
.data


tb1 db 13,10,'tong cac phan tu chia het cho 1:$'
tb2 db 13,10,'$'
array db 1,2,3,4,5,6;
tong db 0


.code
main proc

    mov ax,@data
    mov ds,ax

    lea dx,tb1
    mov ah,09h;
    int 21h;



    mov cx,6; 6 phan tu
    lea si,array; si tro den ngan nho dau tien cua mang
    mov tong,0 ; khoi tao tong = 0
    
    
    duyet:
    mov al,[si] ; dua cac gia tri trong mang do si tro den vao al
    mov bl,1 ;gan bl=1
    mov ah,0 ;xoa bit cao
    div bl ;chia al cho 1
    cmp ah,0 ;so sanh thuong voi 0
    je tinhtong ;neu bang thi tinh tong
    jmp tiep
    
    
    tinhtong:
    mov al,[si] ; dua cac gia trong trong mang do si tro den vao al
    mov bl,tong ; dua tong vao bl
    add al,bl ;cong al voi bl ket qua cat vao al
    mov tong,al ;chuyen ket qua vao bien tong
    
    
    tiep:
    inc si ;tang chi so mang
    inc dl ;tang dl
    
    
    loop duyet
    
    
    mov al,tong ;chuyen so tro lai thanh ghi al
    mov bl,10 ;gan bl =10
    mov cx,0 ;khoi tao bien dem
    
    
    chia:
    mov ah,0 ;xoa bit cao
    div bl ;lay let qua chia cho 10
    mov dl,ah ;chuyen du vao dl
    add dl,30h ;chuyen so sang dang ky tu
    push dx ;day du vao ngan xep
    inc cx ;tang bien dem
    cmp al,0 ;so sanh thuong voi al
    je inso ;neu bang thi in so
    jmp chia
    
    
    inso:
    pop dx
    mov ah,2
    int 21h
    loop inso
    
    
    
    
    mov ah,4ch
    int 21h
main endp
end main
