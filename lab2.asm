;ЛР  №2
;------------------------------------------------------------------------------
; Архітектура комп'ютера
; Завдання:             Вивести на екран надпис зеленого кольору 
; 						у прямокутнику 20х10 синього кольору з координатами кута (2;2)
; ВУЗ:                  КНУУ "КПІ"
; Факультет:    ФІОТ
; Курс:                1
; Група:       ІТ-01
;------------------------------------------------------------------------------
; Автор:        Дмитрієва Ірина
; Дата:         24.02.2021
;---------------------------------
				;I.ЗАГОЛОВОК ПРОГРАМИ
IDEAL			; Директива - тип Асемблера tasm 
MODEL small		; Директива - тип моделі пам’яті 
STACK 256		; Директива - розмір стеку 
				;II.МАКРОСИ
				;III.ПОЧАТОК СЕГМЕНТУ ДАНИХ 
DATASEG
exCode db 0
				;VI. ПОЧАТОК СЕГМЕНТУ КОДУ
CODESEG
Start:
;--------------------------------- 1. Ініціалізація DS и ES---------------------------------------
	mov ax,@data	; @data ідентифікатор, що створюються директивою model	
;----------------------------------2. Операція прямого виводу до відеопам`яті---------------------------------				
	mov ax, 0B800h ; завантажуємо у 16-бітний регістр AX сегментну адресу текстової відеопам`яті
	mov ds, ax	 ; регістр ds вказує на відеопам"ять
	mov es, ax	 ; регістр es - адрес начала видеопамяти
	mov ax,0003h ; перевести графічну систему у відеорежим 2 з очисткою екрану
	int 10h		 ; функція DOS відеосервісу
;----------------------------------3. Початкові дані відповідно до варіанта 9 (1) завдання ---------------------
	mov CX, 18     ; довжина лінії
;	mov ax, 3137h  ; Знак (1 байт) і атрибут (1 байт)    
	mov ah, 23 	; атрибут символа (цвет, фон)			
	mov al, 205	; код символа ("═")		; код символа для виводу лінії
	mov bx, 2*160+1*2					; зсув  для виводу лінії  Y*80*2+X*2 (Y - рядок)
    call paint_line
	
	mov CX, 18     ; довжина лінії
	mov ah, 23 	; атрибут символа (цвет, фон)			
	mov al, 205	; код символа ("═")		; код символа для виводу лінії
	mov bx, 11*160+1*2 	; зсув  для виводу лінії  Y*80*2+X*2 (Y - рядок)
	call paint_line
	
	mov ah, 23 	; атрибут символа (цвет, фон)
	mov al, 201	; код символа ("╔")
	mov bx, 2*160+1*2
	call paint_ch
	
	mov ah, 23 	; атрибут символа (цвет, фон)
	mov al, 187	; код символа ("╗")
	mov bx, 2*160+20*2
	call paint_ch
	
	mov ah, 23 	; атрибут символа (цвет, фон)
	mov al, 200	; код символа ("╚")
	mov bx, 11*160+1*2
	call paint_ch
	
	mov ah, 23 	; атрибут символа (цвет, фон)
	mov al, 188	; код символа ("╝")
	mov bx, 11*160+20*2
	call paint_ch
		
	mov al, 186	; код символа ("║")
	mov bx, 3*160+1*2  ; початок лівого стовпця
	call paint_ch	
	mov bx, 4*160+1*2
	call paint_ch
	mov bx, 5*160+1*2
	call paint_ch
	mov bx, 6*160+1*2
	call paint_ch
	mov bx, 7*160+1*2
	call paint_ch
	mov bx, 8*160+1*2
	call paint_ch
	mov bx, 9*160+1*2
	call paint_ch
	mov bx, 10*160+1*2
	call paint_ch
	mov bx, 3*160+20*2 ; початок лівого стовпця
	call paint_ch
	mov bx, 4*160+20*2
	call paint_ch
	mov bx, 5*160+20*2
	call paint_ch
	mov bx, 6*160+20*2
	call paint_ch
	mov bx, 7*160+20*2
	call paint_ch
	mov bx, 8*160+20*2
	call paint_ch
	mov bx, 9*160+20*2
	call paint_ch
	mov bx, 10*160+20*2
	call paint_ch
;---------------------------------4. Завершення програми---------------------------------------------
	mov ah,4ch ; Завантаження числа 4ch до регістру ah (Функція DOS 4ch - завершення програми)
	mov al,[exCode]	; отримання коду виходу 
	int 21h		; виклик функції DOS 4ch
	
;--------Малювання лінії-------------        
; вхідні  параметри СХ - довжина лінії
;                   AX - Знак (1 байт - AL)  і атрибут (1 байт - AH)
;                   ES -  Початок відеопам`яті          
;					bx - смещение
; вихідні параметри -    
;-------------------------------------       
	PROC paint_line
	my_ptr:
	add bx, 2          				; Сместить координаты
	mov [word es:bx],ax         	; скопіювати ах до відеопам"яті
	LOOP my_ptr        				; Повторить цикл
    ; clear variables
	mov cx, 0 
    xor bx,bx
	xor ax,ax
	ret
    ENDP paint_line
	
	;--------Малювання символу-------------        
	; вхідні  параметри  - довжина лінії
	;                   AX - Знак (1 байт) і атрибут (1 байт)
	;					bx - зсув розраховувати як y*2*80+x*2
	;-------------------------------------   
	PROC paint_ch
	mov [word es:bx],ax         	; скопіювати ах до відеопам"яті
	xor bx,bx
;	xor ax,ax
	ret
    ENDP paint_ch
 

end Start
