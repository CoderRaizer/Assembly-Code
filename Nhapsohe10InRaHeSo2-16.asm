.model small
.stack 10h
.data
    msg1 db 'Nhap so he 10: $'
    msg2 db 13,10,'So he nhi phan: $'
    msg3 db 13,10,'So he 16: $'
    so db 0
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
    
    ; Nhap so thap phan
    mov bl, '0'  
    mov cl, 10d
L1: 
    
    mov al, so ;\
    mul cl     ; \
    mov so, al ;  > so = so * 10 + bl
    sub bl, '0'; /
    add so, bl ;/
     
    mov ah, 01h;\   
    int 21h    ; \ copy al vao bl, kiem tra nhap enter   
    cmp al, 13 ; /
    mov bl, al ;/   
    jne L1     ;
;=============================================================    
    ;In ra so nhi phan
    ;Y tuong in tung bit MSB -> LSB 
    
    lea dx, msg2
    mov ah, 09h
    int 21h
    
    mov bl, so ; luu vao bl de de tinh toan
    mov cx, 8  ; 8bit nhi phan 8 vong lap
    mov ah, 02h; Chuan bi in
L2: 
    mov bh, 0  ; Reset bit bh
    shl bx, 1  ; chuyen bit MSB bl -> LSB bh
    mov dl, bh ; in bh
    add dl, '0'; Chuyen sang Ascii
    int 21h
    loop L2    
;=============================================================
    ;In ra so 16
    ;Y tuong nhu bai 9
    
    mov ah, 09h
    lea dx, msg3
    int 21h
    
    mov ch, 0
    mov cl, so
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
;=============================================================    
    mov ah, 4ch
    int 21h
main endp

endp main