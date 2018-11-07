;Program:
;Author:
;Date:

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA                   ; reserve storage for data
Prompt0         BYTE    "Input The Score:",0
Input_Number    BYTE    8 DUP(?)
GradeA          BYTE    "This score is Grade A.",0
GradeB          BYTE    "This score is Grade B.",0
GradeC          BYTE    "This score is Grade C.",0
Overflow        BYTE    "This score is OVERFLOW",0
.CODE                           ; start of main program code
_start:
    output Prompt0
    input Input_Number,8
    atod Input_Number
    CMP EAX, 100
    JG  ERROR_OVERFLOW
    CMP EAX, 80
    JGE GRADE_A
    CMP EAX, 60
    JGE GRADE_B
    CMP EAX, 0
    JLE ERROR_OVERFLOW
    output GradeC
    JMP End_CMP
    GRADE_A: output GradeA
    JMP End_CMP
    GRADE_B: output GradeB
    JMP End_CMP
    ERROR_OVERFLOW: output Overflow
    End_CMP:

        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

