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
        Prompt0    BYTE    "This program will evaluate the expression like ",cr,Lf,Lf
                   BYTE    "    2(-x+y-1)+z",cr,Lf,Lf
                   BYTE    "Input value of X:",0
        Prompt1    BYTE    "Input value of Y:",0
        Prompt2    BYTE    "Input value of Z:",0
        Value      BYTE     16 DUP(?)
        Prompt3    BYTE    "The result is:"
        Result     BYTE     16 DUP(?)
.CODE                           ; start of main program code
_start:
        output Prompt0
        input  Value,16
        atoi   Value
        imul   ax, -1
        output Prompt1
        input  Value,16
        atoi   Value
        add    bx, ax
        dec    bx
        imul   bx, 2
        output Prompt2
        input  Value,16
        atoi   Value
        add    bx, ax
        itoa   Result, bx
        output Result
        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

