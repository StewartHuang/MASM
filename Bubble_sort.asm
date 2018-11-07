;Program:
;Author:
;Date:

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed
maxSize EQU     10

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
array       DWORD   maxSize dup(?)
inputnum    BYTE    8 dup(?)
prompt1     BYTE    "Input a number: ", 0
prompt0     BYTE    "The biggest number is: "
biggest     BYTE    11 DUP(?)
.CODE                           ; start of main program code
_start:

    LEA EBX, array	   ;取数组的首地址
    MOV ECX, 10          ;控制输入循环次数
L9: output prompt1     ;输入循环
    input  inputnum, 8
    atod   inputnum
    MOV [EBX], EAX
    ADD EBX,4
    LOOP L9

    LEA EBX, array
    MOV EAX, [EBX]
    ADD EBX, 4
    MOV ECX, 9
L0: CMP EAX, [EBX]
    JGE L1
    mov EAX, [EBX]
L1: ADD EBX,4
    LOOP L0
    dtoa biggest, EAX
    output prompt0

        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

