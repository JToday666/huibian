.model small
.stack
.code
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段
    call read
    push ax
    call read
    push ax
    call GCD        ; 调用 GCD 子程序
    add sp, 2
    pop dx  ; 将结果保存到dx
    call print_num
    ; 程序结束
    mov ah, 4Ch
    int 21h  

GCD proc
    ;;//TEMPLATE BEGIN
    ;;//书写代码
    push bp
    mov bp, sp
    push ax
    push bx
    mov ax, [bp+6]
    mov bx, [bp+4]
    cmp bx, 0
    je done
again:
    cmp ax, bx
    jb next
    sub ax, bx
    jmp again
next:
    push bx
    push ax
    call GCD
    add sp, 2
    pop ax
    mov [bp+6], ax
done:
    pop bx
    pop ax
    pop bp
    ret
    ;;//TEMPLATE END
GCD endp

print_num proc
    ;;//TEMPLATE BEGIN
    ;;//书写代码
    push ax
    push bx
    push cx
    push dx
    mov cx, 10          ;; 除数
    mov ax, dx
    div cl
    xor dx, dx
    xor bx, bx
    mov dl, al
    mov bl, ah
    push bx
    cmp dx, 0
    je next1
    call print_num
next1:
    pop bx
    mov ax, bx
    mov bx, offset ascii
    xlat ascii
    mov dl, al
    mov ah, 2
    int 21h
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
ascii db  30h, 31h, 32h, 33h, 34h, 35h, 36h, 37h, 38h, 39h, 41h, 42h, 43h, 44h, 45h, 46h
    ;;//TEMPLATE END
print_num endp


Read proc
	push bx
	push cx
	push dx
	xor bx,bx
	xor cx,cx
read1:	mov ah,1
	int 21h
	cmp al,'0'
	jb read4
	cmp al,'9'
	ja read4
	sub al,30h
	shl bx,1
	mov dx,bx
	shl bx,1
	shl bx,1
	add bx,dx
	mov ah,0
	add bx,ax
	jmp read1
read4:	mov ax,bx
	pop dx
	pop cx
	pop bx
	ret
Read	endp

end main
