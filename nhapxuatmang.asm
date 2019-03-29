.model	small
.stack	10h
.data
				tb1	db	13, 10, 'Nhap mang: $'
				tb2	db	13, 10, 'Mang da nhap: $'
				tb3	db	' $'
				tb4	db	13, 10, 'Nhap so phan tu mang: $'
				tb5	db	13, 10, 'Nhap sai. Nhap lai: $'
				array	dw	100	dup(0)
				so		dw	0
				temp	dw	0
				soPTMang dw	0
.code
main proc       
                
                
				mov ax, @data
				mov ds, ax
				
	
	nhapSoPT:
				mov ah, 09h
				lea dx, tb4
				int 21h
	
	lap:
				mov ah, 01h
				int 21h
				
				cmp al, 13
				je	kiemtra
				
				mov ah, 0
				sub ax, 30h
				mov bx, soPTMang
				mov soPTMang, ax
				mov ax, 10
				mul bx
				add ax, soPTMang
				mov soPTMang, ax
				jmp	lap
				
	kiemtra:	
				cmp soPTMang, 0
				ja	start0
				
				mov ah, 09h
				lea dx, tb5
				int 21h
				jmp	nhapSoPT
				
	start0:
				mov cx, soPTMang
				lea SI, array
				
	start:			
				mov ah, 09h
				lea dx, tb1
				int 21h
				
	nhapmang:			
				mov ah, 01h
				int 21h
				cmp al, 13
				je	luumang
				
				mov ah, 0
				sub ax, 30h
				mov bx, so
				mov so, ax
				mov ax, 10
				mul bx
				add	ax, so
				mov so, ax
				jmp nhapmang
				
	luumang:	
				mov ax, so
				mov [SI], ax
				add SI, 2
				mov so, 0
				
				loop start
				
				
				;////////////////////////////////////
				
				mov cx, soPTMang
				
				mov ah, 09h
				lea dx, tb2
				int 21h
				
				mov so, 0
				lea SI, array
				
	xuatMang:
				mov ax, [SI]
				
	chia:		
				mov bx, 10
				mov dx, 0
				div bx
				inc temp
				push dx
				cmp ax, 0
				jne	chia
				
	xuatPhanTu:
				pop dx
				add dx, 30h
				mov ah, 02h
				int 21h
				
				dec temp
				mov ax, temp
				cmp ax, 0
				jne xuatPhanTu
				
				;in khoang trang
				mov ah, 09h
				lea dx, tb3
				int 21h
				
				add SI, 2
				mov temp, 0
				
				loop xuatMang				
				
				mov ah, 4ch
				int 21h
				main endp
				end main