.model small
.stack
.data
    num1 dw ?       ; 输入的第一个整数 (a)
    num2 dw ?       ; 输入的第二个整数 (b)

.code
main:
    mov ax, @data
    mov ds, ax      ; 初始化数据段

    call read
    mov num1, ax
    call read
    mov num2, ax
    call GCD        ; 调用 GCD 子程序
    mov dx, num1  ; 将结果保存到dx
    call print_num
    ; 程序结束
    mov ah, 4Ch
    int 21h 
GCD proc
    ;;//TEMPLATE BEGIN
    ;;//书写代码
    cmp num2, 0
    je done                      ; 结束
    mov bx, num1
again:
    cmp bx, num2
    jb next                      ; num1小
    sub bx, num2
    jmp again
next:
    
done:
    ret
    ;;//TEMPLATE END
GCD endp


print_num proc 
    ;;//TEMPLATE BEGIN
    ;;//书写代码
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