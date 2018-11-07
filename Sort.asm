;Program:
;Author:
;Date:

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed
maxSize EQU     3       ;maxsize of array

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
    inputnum    BYTE    8 dup(?)
    outputnum   BYTE    8 dup(?)
    array       DWORD   maxSize dup(?)
    prompt1         BYTE    "Input a number: ", 0
    prompt2         BYTE    cr,Lf,"Sorted array is :", 0
.CODE                           ; start of main program code
_start:
    LEA EBX, array	   ;取数组的首地址
    MOV ECX, 3          ;控制输入循环次数
L0: output prompt1     ;输入循环
    input  inputnum, 8
    atoi   inputnum
    MOV [EBX], EAX
    ADD EBX,4
    LOOP L0

    LEA EBX, array	   ;取数组的首地址
	MOV ECX, 3	   ;控制排序循环次数
	XOR ESI, ESI	   ;将ESI清零
	XOR EDI, EDI	   ;将EDI清零
L1: MOV EAX, [EBX+ESI]  ;用基变址寻址取操作数，L1为外循环，(ESI)为循环变量，;相当于i
L2: MOV EDX, [EBX+EDI]  ;L2为内循环，(EDI)为循环变量，相当于j
	CMP EAX, EDX
	JLE L3
	XCHG EAX, EDX      ;EAX>EDX，交换两个数
	MOV [EBX+EDI],EDX
	MOV [EBX+ESI],EAX
L3: ADD  EDI,4         ;EAX>=EDX，不需交换，(AH)直接和后一个数比较，相当于j++
	CMP  EDI,12	;判断内层循环是否结束
	JL   L2  	;没结束，继续循环;
	ADD  ESI,4		;结束了,外层变量SI加一，相当于i++
	MOV  EDI,ESI	;相当于j=i
	LOOP L1


    LEA EBX, array	   ;取数组的首地址
    MOV ECX, 3          ;控制排序循环次数
L4: output prompt2     ;输出循环
    itoa inputnum,[EBX]
    output inputnum
    ADD EBX,4
    LOOP L4

        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

