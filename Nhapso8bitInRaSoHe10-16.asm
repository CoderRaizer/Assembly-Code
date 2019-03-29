.model small
.stack 10h
.data
    msg1 db 'Nhap vao day 8bit: $'
    msg2 db 13,10,'So he 10: $'
    msg3 db 13,10,'So he 16: $'

    s1 db ? ; luu so hang tram
    s2 db ? ; luu so hang chuc
    s3 db ? ; luu so hang don vi
    s4 db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' ; tu dien in he 16
.code 
main proc
    mov ax, @data
    mov ds, ax    
;=============================================================    
    ; In thong bao nhap
    lea dx, msg1
    mov ah, 09h
    int 21h
    
    ;Nhap 8 bit tu ban phim
    mov bx, 0
    mov cx, 8
    mov ah, 01h
    
L1: 
    int 21h
    sub al, '0'
    shl bl, 1
    or bl, al
    loop L1 
    ;Ket thuc nhap ket qua luu vao bl
;=============================================================    
    ;Chuyen doi sang he 10
    ;Y tuong lay tung bit cuoi ra tinh
    mov dl, bl ; Copy bl vao dl   
    mov cl, 0  ; gia tri vong lap
    mov ch, 0  ; Luu gia tri sau khi tinh xong he 10
    
L2: 
    mov al, 1b ;\
    and al, dl ; > Lay bit LSB tu dl, nhan voi 2^cl == dich al sang trai cl bit  
    shl al, cl ;/
    add ch, al ; Cong 2^cl vao ch
    shr dl, 1  ; Tinh den bit LSB + 1
    inc cl     ;\ 
    cmp cl, 7  ; > vi 8bit nen den bit 7 thi dung 
    jbe L2     ;/         
    ;Da doi sang he 10 va luu vao ch
;=============================================================    
    ;In ra so he 10
    ;Vi so nhap 8 bit max = 255d (ko tinh so am)
    ;So hang tram = so / 100
    ;So hang chuc = so_du_khi_chia_cho_100 / 10
    ;So hang don vi = so_du_khi_chia_cho_100 % 10
    
    mov ah, 0  ; Xoa thanh ghi ah truoc
    mov dl, 100d
    mov al, ch ; Chuyen du lieu vao al, chia al cho 100d
    div dl     ; phan thuong luu vao al, du ah
    mov s1, al ; Luu so hang tram
    mov s2, ah ; Luu so hang don vi va hang chuc
    
    mov dl, 10d;\
    mov al, ah ; >Chuan bi chia tiep                                                    
    mov ah, 0  ;/ Xoa thanh ghi ah truoc
    div dl     ;\
    mov s2, al ; >Chia va luu so hang chuc & don vi
    mov s3, ah ;/
    
    ; Chuan bi in ra so he 10
    mov ah, 09h
    lea dx, msg2
    int 21h
    mov ah, 02h
    
    ; So hang tram                  
    add s1, '0'; Chuyen sang ASCII
    mov dl, s1 ;
    int 21h    ;   
    ; So hang chuc
    add s2, '0'; Chuyen sang ASCII
    mov dl, s2
    int 21h
    ; So hang don vi   
    add s3, '0'
    mov dl, s3
    int 21h
;=============================================================   
    ;In ra so he 16
    ;Vi so nhap 8 bit max = FFh (ko tinh so am)    
    ;So hang chuc = 4bit dau
    ;So hang don vi = 4bit cuoi
    
    mov ah, 09h
    lea dx, msg3
    int 21h
    
    mov cx, bx; copy bx vao cx vi phai dung bx de luu dc mang s4 
    shl cx, 4 ; so hang chuc 4bit dau cua cl dich trai = 4 bit cuoi cua ch
    shr cl, 4 ; so hang don vi vi da dich cx nen dich nguoc lai 4bit
        
    lea bx, s4 ; nap bang s4 vao bx
    mov al, ch ; chi so hang chuc cua bang s4
    xlat       ; lay gia tri s4[ch] vao al
    mov ah, 02h;
    mov dl, al ; nap vao dl de hien thi so hang chuc
    int 21h
    
    mov al, cl ; chi so hang don vi cua bang s4
    xlat       ; lay gia tri s4[cl] vao al
    mov dl, al ; nap vao dl de hien thi so hang don vi
    int 21h   
                
    mov ah, 4ch
    int 21h
main endp
endp main
