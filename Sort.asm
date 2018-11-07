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
    LEA EBX, array	   ;ȡ������׵�ַ
    MOV ECX, 3          ;��������ѭ������
L0: output prompt1     ;����ѭ��
    input  inputnum, 8
    atoi   inputnum
    MOV [EBX], EAX
    ADD EBX,4
    LOOP L0

    LEA EBX, array	   ;ȡ������׵�ַ
	MOV ECX, 3	   ;��������ѭ������
	XOR ESI, ESI	   ;��ESI����
	XOR EDI, EDI	   ;��EDI����
L1: MOV EAX, [EBX+ESI]  ;�û���ַѰַȡ��������L1Ϊ��ѭ����(ESI)Ϊѭ��������;�൱��i
L2: MOV EDX, [EBX+EDI]  ;L2Ϊ��ѭ����(EDI)Ϊѭ���������൱��j
	CMP EAX, EDX
	JLE L3
	XCHG EAX, EDX      ;EAX>EDX������������
	MOV [EBX+EDI],EDX
	MOV [EBX+ESI],EAX
L3: ADD  EDI,4         ;EAX>=EDX�����轻����(AH)ֱ�Ӻͺ�һ�����Ƚϣ��൱��j++
	CMP  EDI,12	;�ж��ڲ�ѭ���Ƿ����
	JL   L2  	;û����������ѭ��;
	ADD  ESI,4		;������,������SI��һ���൱��i++
	MOV  EDI,ESI	;�൱��j=i
	LOOP L1


    LEA EBX, array	   ;ȡ������׵�ַ
    MOV ECX, 3          ;��������ѭ������
L4: output prompt2     ;���ѭ��
    itoa inputnum,[EBX]
    output inputnum
    ADD EBX,4
    LOOP L4

        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

