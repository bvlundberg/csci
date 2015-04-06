; Author:		Brandon Lundberg
; File Name:	lab7.asm
; Purpose:		Selection sort
; Date:			19 March 2015

; Input:		A string of 10 numbers
; Output:		
.586
.MODEL FLAT
INCLUDE io.h
.STACK 4096

.DATA
prompt1			BYTE "Enter 10 scores separated by a space",0
prompt2			BYTE "output is: ",0
scoreString     BYTE 80 dup(?),0; //for 10 scores - make enough room
scoreArray		DWORD 10 dup (?)
temp			BYTE 11 dup(?),0
tempx			BYTE 11 dup(" "),0;     //or,..dup(20H); 20H=space
temp2			BYTE 11 dup(?),0
outputstring	BYTE "Original: ", 250 DUP(20H), 0 ; Size 10
label1			BYTE "Sorted: ",0
count1			DWORD 0

count2 DWORD 0
sorted	DWORD 10 dup (?)

.CODE
_MainProc PROC
        input	prompt1, scoreString, 40; //gets 10 scores
        lea		ebx, scoreString
        
 outerLoop: inc count1; //outer loop counter++
			lea esi, tempx; //flush temp string before using
			lea edi, temp
			cld
			mov ecx, 11
			rep movsb
        
			lea edx, temp;

 innerLoop: cmp byte ptr[ebx], 20h; //if ending mark(space), done
			je done1; 
			cmp byte ptr[ebx], 00h;     //elsif null char, also done
			je done1;
			mov AL, byte ptr[ebx]; //otherwise, get 1 byte from input string
			mov [edx], AL;         //and move it to temp

			inc ebx;       //to next byte in input string
			inc edx;       //to next byte in temp string
			jmp innerLoop; //inner loop (temp <- one score)
        
 done1:		output prompt2, temp; test display of temp 
			atod temp; //eax <- temp

			mov ecx, count1;
			dec ecx;       //counter:1 -> array index:0
			imul ecx, 4;   //array ele size = 4 bytes
			mov scoreArray[ecx], eax; //store one score in array
			 
			inc ebx;       //skip the end mark(space) in the input string
			cmp count1, 10; //loop 10 times
			jnge outerLoop
			
			dtoa temp2, scoreArray[0]; or, scorearray+0; //testing display
			output  prompt2, temp2

		; Set array counter to zero
		mov		ecx,0
		; Copy data to sorted array
Copy:
		mov eax, scoreArray[ecx]
		mov sorted[ecx], eax
		add ecx, 4		; Increase counter to next value
		inc count2
		cmp count2, 10
		jl Copy

		; Selection sort
		mov		ebx, 0	; First index
		mov		ecx, 0  ; First index
		mov		edx, 4	; Second index
OutLoop:
		mov		eax, sorted[ebx]	; Get value of current element
InLoop:		
		; Find index for current smallest element
		cmp		eax, sorted[edx]
		jg		MinValue
Continue:
		; Check counter for inner loop
		add		edx, 4
		cmp		edx, 40
		jl		InLoop
		; Swap current index with highest value
		mov		eax, sorted[ecx]
		xchg	sorted[ebx], eax
		mov		sorted[ecx], eax
		; Check counter for outer loop
		add		ebx, 4
		mov		ecx, ebx
		mov		edx, ebx
		add		edx, 4
		cmp		ebx, 36
		jl		OutLoop
		; Jump to printing
		jmp		PrintResults
MinValue:
		mov		ecx, edx
		mov		eax, sorted[edx]
		jmp		Continue

PrintResults:
		; Append scoreArray to output string
		mov edx, 0
		mov ebx, 10
OutputOriginal:
		; Print the results of the first array
		mov eax, scoreArray[edx]
		dtoa temp2, eax
		lea esi, temp2[1]
		lea edi, outputstring[ebx]
		cld
		mov ecx, 10
		rep movsb
		add ebx, 10
		add edx, 4
		cmp edx, 40
		jl OutputOriginal

		mov		outputstring + 110, 0AH

		; Sorted label to output
		lea     esi, label1
		lea     edi, outputstring + 111
		cld       
		mov     ecx, 8
		rep     movsb
		mov     outputstring + 119, 20H
		mov		outputstring + 120, 20H
		mov     outputstring + 121, 20H
		mov edx, 0
		mov ebx, 122

OutputSorted:
		mov eax, sorted[edx]
		dtoa temp2, eax
		lea esi, temp2[1]
		lea edi, outputstring[ebx]
		cld
		mov ecx, 10
		rep movsb
		add ebx, 10
		add edx, 4
		cmp edx, 40
		jl OutputSorted

		output prompt2, outputstring

		mov     eax, 0
		ret
_MainProc ENDP
END





