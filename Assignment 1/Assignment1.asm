;Assignment1 - finds the sum, difference, product, quotient and remainder of two numbers

TITLE Assignemtn 1 (Assignment1.asm)


;Author: Lauren Boone
;Date: 4/4/19
;Course/Project ID: CS 271
;Assignment 1
;Descripion: Performs calculations on two user defined intergers
	;Finds sum, difference, product, quotient and remainder
	;All thre EC options are executed

INCLUDE Irvine32.inc



.data

;string data for displaying on screen

programmer		BYTE	"Name: Lauren Boone", 0
prog_title		BYTE	"Assignment 1", 0
instructions	BYTE	"Please enter two numbers. The sum, difference, product, quotient and remainder will be calculated ", 0
terminate		BYTE	"Program is ending... goodbye", 0 
input_1			BYTE	"First Number: " , 0
num_too_high		BYTE	"Oops, Number 2 must be less than number 1" ,0
input_2			BYTE	"Second Number: " , 0
str_sum			BYTE	"Sum: " , 0
str_diff		BYTE	"Difference: " ,0
str_product		BYTE	"Product: " , 0
str_quotient	BYTE	"Quotient: " ,0
str_remainder	BYTE	"Remainder: " , 0
add_sign		BYTE	" + ",0
sub_sign		BYTE	" - ",0
mult_sign		BYTE	" * ",0
div_sign		BYTE	" / ",0
equal			BYTE	" = ",0




;numerical data used for calculations

num1			DWORD	0
num2			DWORD	0
sum				DWORD	0
difference		DWORD	0
product			DWORD	0
quotient		DWORD	0
remainder		DWORD	0



;EC data for float point qutotient results
float_quotient	REAL8	0.00
by1000			DWORD	1000
dot				BYTE	".",0
temp			DWORD	0
newQuotient		DWORD	?
remain_float	DWORD	0
first			DWORD	?
second			DWORD	?


;EC Introduction Section

EC_instruct1	BYTE	"**E.C. Loop untill user wants to Quit",0
EC_instruct2	BYTE	"**E.C. Validate second number is less that first",0
EC_instruct3	BYTE	"**E.C Calculate and display quotient as floating point number, to nearest .001" , 0
EC_Loop			BYTE	"Would you like to quit? (1 to continue/ 2 to quit)",0
endLoop			DWORD	0






;Start main program
.code
main PROC

;Loops through program untill user wants to quit
L1:

;print information for user
;prints EC information


		;print programmer name
	mov			EDX, OFFSET programmer
	call	WriteString
	call	CrLf

		;print program title
	mov			EDX, OFFSET prog_title
	call	WriteString
	call	CrLf

		;print instructions
	mov			EDX, OFFSET instructions
	call	WriteString
	call	CrLf
	call	CrLf

		;print EC 1
	mov			EDX, OFFSET EC_instruct1
	call	WriteString
	call	CrLf

		;print EC 2
	mov			EDX, OFFSET EC_instruct2
	call	WriteString
	call	CrLf

		;print EC 3
	mov			EDX, OFFSET EC_instruct3
	call	WriteString
	call	CrLf
	call	CrLf





;Ask user for number 1 then number 2
;Jump to function to check that value 2 is less than number 1
GETINPUT:
;Get numerical Values

		;Get user input for number 1
	mov			EDX, OFFSET input_1
	call	WriteString
	call	ReadInt
	mov			num1, EAX
	
		;Get user input for number 2
	mov			EDX, OFFSET input_2
	call	WriteString
	call	ReadInt
	mov			num2, EAX
	jmp		CHECKVALUE
	call	CrLF





;Check to make sure the second value is less than the first
;if false the program loops back to get input for both numbers again
;this is done untill value 2 is les than value 1
CHECKVALUE:
	
	;Check to see if num2 is less than num1
	mov		EAX, num1
	mov		EBX, num2
	cmp		EBX, EAX
	jbe		CALCULATIONS

	;If num2 is greater than num1, repeat user input
	mov			EDX, OFFSET num_too_high
	call	WriteString
	call	CrLf
	call	CrLf
	jmp		GETINPUT





;Perform Calcutions
CALCULATIONS:

		;Find sum
	mov		EAX, num1
	mov		EBX, num2
	add		EAX, EBX
	mov		sum, EAX

		;Differnece
	mov		EAX, num1
	mov		EBX, num2
	sub		EAX, EBX
	mov		difference, EAX

		;product
	mov		EAX, num1
	mov		EBX, num2
	mul		EBX
	mov		product, EAX
	
		;Quotient/Remainder
	mov		EDX, 0
	mov		EAX, num1
	cdq
	mov		EBX, num2
	cdq
	div		EBX
	mov		quotient, EAX
	mov		remainder, EDX

	
		;Covert to floating point number for quotient
	fld		num1					;put num 1 at st(0)
	fdiv	num2					;div st(0) by num2
	fimul	by1000					;convert st(0) to float then mult by 100
	frndint			
	fist	newQuotient				;store value at st(0) at address newQuotient
	fst		float_quotient
	mov		EDX, 0
	mov		EAX, newQuotient
	cdq
	mov		EBX, by1000
	cdq
	div		EBX
	mov		first, EAX
	mov		EDX, 0
	mov		EAX, first			;mult first value by 1000, then subtract value from newQuotient to find second
	mov		EBX, by1000
	mul		EBX
	mov		temp, EAX
	mov		EAX, newQuotient
	mov		EBX, temp
	sub		EAX, EBX
	mov		second, EAX



;Print Calculation results

		;Print Sum
	mov			EDX, OFFSET str_sum
	call	WriteString
	mov			EAX, num1
	call	WriteDec
	mov			EDX, OFFSET	add_sign
	call	WriteString
	mov			EAX, num2
	call	WriteDec
	mov			EDX, OFFSET	equal
	call	WriteString
	mov			EAX, sum
	call	WriteDec
	call	CrLf


		;Print Difference
	mov			EDX, OFFSET str_diff
	call	WriteString
	mov			EAX, num1
	call	WriteDec
	mov			EDX, OFFSET	sub_sign
	call	WriteString
	mov			EAX, num2
	call	WriteDec
	mov			EDX, OFFSET	equal
	call	WriteString
	mov			EAX, difference
	call	WriteDec
	call	CrLf


		;Print Product
	mov			EDX, OFFSET str_product
	call	WriteString
	mov			EAX, num1
	call	WriteDec
	mov			EDX, OFFSET	mult_sign
	call	WriteString
	mov			EAX, num2
	call	WriteDec
	mov			EDX, OFFSET	equal
	call	WriteString
	mov			EAX, product
	call	WriteDec
	call	CrLf


		;Print Quotient
	mov			EDX, OFFSET str_quotient
	call	WriteString
	mov			EAX, num1
	call	WriteDec
	mov			EDX, OFFSET	div_sign
	call	WriteString
	mov			EAX, num2
	call	WriteDec
	mov			EDX, OFFSET	equal
	call	WriteString
	mov			EAX, first
	call	WriteDec
	mov			EDX, OFFSET dot
	call	WriteString
	mov			EAX, second
	call	WriteDec
	call	CrLf
	

		;Print Remainder
	mov			EDX, OFFSET str_remainder
	mov			EAX, remainder
	call	WriteString
	call	WriteDec
	call	CrLF
	jmp	PLAYAGAIN



;Ask user if they would like to continue or quit
;if they want to quit, jump to ENDPROGRAM
PLAYAGAIN:
	
		;Ask for user to decide if they want to continue
	mov			EDX, OFFSET	EC_Loop
	call	WriteString
	call	CrLf
	call	ReadInt
	mov			endLoop, EAX

		;Check if they entered to continue or quit and call necessary loop or function
	mov			EAX, endLoop
	cmp		EAX, 2
	jb		L1
	jae		ENDPROGRAM
	

;Ends Program
;display goodbye message
ENDPROGRAM:

	;If the user wants to quit
	mov			EDX, OFFSET	terminate
	call	WriteString
	call	CrLf

exit

main ENDP
END main
