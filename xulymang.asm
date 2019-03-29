.model	small
.stack	10h
.data



		tb1	 db	 13,10, 'Nhap so phan tu mang: $'
		tb2	 db	 13,10, 'Nhap mang: $'
		tb3	 db	 13,10, 'Mang da nhap: $'
		tb4	 db	 13,10, 'Nhap sai. Nhap lai: $'
		tb5	 db	 13,10, 'Tong cac phan tu mang: $'
		tb6  db  13,10, 'Max : $'
		tb7  db  13,10, 'Min : $'
		tb8  db  13,10,  'So Phan Tu Chan: $'
		tb9  db  13,10,  'So Phan Tu Le: $'
		tb10 db  13,10,  'Tong Phan Tu Chan: $'
		tb11 db  13,10,  'Tong Phan Tu Le: $'
		tb12 db  13,10,  'Nhap phan tu can tim kiem trong mang: $'
		tb13 db  13,10,  'Co Ton Tai $'
		tb14 db  13,10,  'Khong Ton Tai $'
		space	db	' $'
				
		array	       dw	    100	dup(0)
		so		       dw	    0
		temp	       dw	    0; chua so lan phan tach
		soPTMang       dw	    0
		
		tong           dw       0
		max            dw       0
		min            dw       999
		
		sophantuchan   dw       0
		sophantule     dw       0
		tongsochan     dw       0
		tongsole       dw       0
		sample         dw       0
		numberSearch   dw       0
		xacnhantontai  dw       0

		
		
				
.code           
main proc
    
		mov ax, @data
		mov ds, ax
				
	
nhapsoPT:
		mov ah, 09h
		lea dx, tb1
		int 21h
	
	inputsoPT:
		mov ah, 01h
		int 21h		
		CMP al, 13
		JE check		
		mov ah, 0
		sub al, 30h
		mov cx,ax;
		mov ax,soPTMang
		mov bx,10;
		mul bx;
		add ax,cx;
		mov soPTMang,ax
		JMP	inputsoPT
	
				
	check:	
		CMP soPTMang,0
		JA	done;		
		mov ah, 09h
		lea dx, tb4
		int 21h
		JMP	nhapsoPT
	
			
	done:
		mov cx,soPTMang
		lea si,array
	
			
	nhapmang:			
		mov ah, 09h
		lea dx, tb2
		int 21h
				
	inputPT:			
		mov ah,01h
		int 21h
		CMP al,13
		JE	luuvaomang
		mov ah,0
		sub al,30h
				
		mov bx,so;
		mov so,ax;
		mov ax,10;
		mul bx;
		add ax,so;
		mov so,ax;
		JMP inputPT
				
	luuvaomang:	
		mov ax,so;
        
		call tongPhanTuMang;---them o day
		call timMax;---them o day
		call timMin;---them o day
        
        mov sample,ax
		mov [SI],ax
		
		;tim phan tu chan le
		mov bl,2;
		mov ah,0;xoa bit cao
		div bl;chia ax cho 2
		
		CMP ah,0; thuong (al) du <ah> - kiem tra ah co phai la 0
		JE tangsophantuchan
		CMP ah,0
		JNE tangsophantule
		
		
		tangsophantuchan:
		call tinhtongSoChan;
		add sophantuchan,1;
		JMP now
		
		tangsophantule:
		call tinhtongSoLe;
		add sophantule,1;
		JMP now
		
		
		now:
		add SI,2; tang con tro SI len index moi
		mov so,0; gan cho 'so' = 0 de chua phan tu moi cua mang
		loop nhapmang
				
				
	    ;////////////////////////////////////
		
		
		mov ah, 09h
		lea dx, tb3
		int 21h
				
	    mov cx, soPTMang	
		mov so, 0
		lea SI, array
				
	
	
	    XuatMang:
		mov ax,[SI]; den dia chi ma con tro SI dang chua du lieu truyen cho ax

	    phantach:		       
		mov bx,10
		mov dx,0
		div bx
		push dx
		inc temp
		cmp ax,0
		JE XuatPhanTu
		jne	phantach
	
				
	    XuatPhanTu:
		pop dx
		add dl,30h		
		mov ah,02h
		int 21h
				
		dec temp		
		mov ax,temp
		CMP ax,0
		JNE XuatPhanTu
				
				
		;in khoang trang
		mov ah, 09h
		lea dx, space
		int 21h
				
		add SI,2
		mov temp,0		
		loop XuatMang				
				
		
		
		
		
		;/////////// IN RA TONG ///////////;		
		mov ah,09h;
		lea dx,tb5;
		int 21h;
				
		
		mov ax,tong;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
    
        phantachtong:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienTong
        xor dx,dx;xoa bit cao trong dx
        JMP phantachtong
    
        HienTong:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienTong;
        

        
        ;/////////// IN RA MAX ///////////;
        
        mov ah,09h;
        lea dx,tb6;
        int 21h;
        
		mov ax,max;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
        phantachmax:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienMAX
        xor dx,dx;xoa bit cao trong dx
        JMP phantachmax
    
        HienMAX:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienMAX;
        
        
        xor dx,dx
        
        ;/////////// IN RA MIN ///////////;
        mov ah,09h;
        lea dx,tb7;
        int 21h;
        
		mov ax,min;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
        phantachmin:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienMIN
        xor dx,dx;xoa bit cao trong dx
        JMP phantachmin
    
        HienMIN:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienMIN;
        
        
        ;/////////// IN RA SO PHAN TU CHAN ///////////;
        mov ah,09h;
        lea dx,tb8;
        int 21h;
        
        mov ax,sophantuchan;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
        phantachsophantuchan:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienSOPHANTUCHAN
        xor dx,dx;xoa bit cao trong dx
        JMP phantachsophantuchan
    
        HienSOPHANTUCHAN:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienSOPHANTUCHAN;
			    
		
		
		;/////////// IN RA SO PHAN TU LE ///////////;
		mov ah,09h;
        lea dx,tb9;
        int 21h;
        
        mov ax,sophantule;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
        phantachsophantule:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienSOPHANTULE
        xor dx,dx;xoa bit cao trong dx
        JMP phantachsophantule
    
        HienSOPHANTULE:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienSOPHANTULE;
        
        
        
        ;/////////// IN RA TONG SO CHAN ///////////;
        mov ah,09h;
        lea dx,tb10;
        int 21h;
        
        mov ax,tongsochan;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
        phantachtongsochan:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienTONGCHAN
        xor dx,dx;xoa bit cao trong dx
        JMP phantachtongsochan
    
        HienTONGCHAN:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienTONGCHAN;
        
        
        ;/////////// IN RA TONG SO LE ///////////;		
		mov ah,09h;
        lea dx,tb11;
        int 21h;
        
        mov ax,tongsole;
        mov bx,10;
        mov cx,0; bien dem cua vong lap
        mov dx,0;
    
        phantachtongsole:
        div bx;lay tong trong ax / 10
        push dx;du o dx day vao stack
        inc cx;
        cmp ax,0;so sanh thuong voi 0
        JE HienTONGLE
        xor dx,dx;xoa bit cao trong dx
        JMP phantachtongsole
    
        HienTONGLE:
        pop dx;lay du trong stack ra khoi dx
        add dl,30h;chuyen so thanh ky tu
        mov ah,02h;
        int 21h;
        loop HienTONGLE;
		
		
		
		
		
		
		;/////////// IN RA KET QUA TIM KIEM ///////////;
		mov ah,09h;
		lea dx,tb12;
		int 21h;
		
		Nhap:
        mov ah,01h;
        int 21h;
        cmp al,13
        JE TimKiem
        mov ah,0;
        sub al,30h;chuyen thanh so
        mov cx,ax;chuyen so vua nhap vao cx
        mov ax,numberSearch;chuyen gia tri soA vao ax
        mov bx,10;gan bx = 10
        mul bx;nhan ax cho 10
        add ax,cx;
        mov numberSearch,ax;
        JMP Nhap;
        
        
        
        
        
        TimKiem:
        mov ax,numberSearch;
		mov bx,[SI]; den dia chi ma con tro SI dang chua du lieu truyen cho ax
        cmp bx,ax;
        JE Have;
        JMP next;
        
        Have:
        mov ax,1;
        JMP CO;
        next:  		
		add SI,2		
		loop TimKiem
        
        
        ;cmp ax,1
        ;JE CO
        cmp ax,1
        JNE KHONG
        
        
        CO:
        mov ah,09h;
        lea dx,tb13;
        int 21h;
        JMP exit

		KHONG:
		mov ah,09h;
        lea dx,tb14;
        int 21h;
        JMP exit
		
		
		exit:
				
mov ah, 4ch
int 21h


main endp


;///// Chuong Trinh Con /////;

tongPhanTuMang proc
add tong,ax;
ret    
tongPhanTuMang endp


timMax proc
CMP ax,max;
JA changeMax
JMP exit1
changeMax:
mov max,0;
mov max,ax;
exit1:
ret
timMax endp



timMin proc
CMP ax,min;
JB changeMin
JMP exit2
changeMin:
mov min,0;
mov min,ax;
exit2:
ret
timMin endp


tinhtongSoChan proc
mov ax,sample;
add tongsochan,ax;        
ret
tinhtongSoChan endm

tinhtongSoLe proc
mov ax,sample;
add tongsole,ax;        
ret
tinhtongSoLe endm

;///// Chuong Trinh Con /////;

end main