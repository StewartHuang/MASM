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
shuzu             WORD       -1,-2,-3,-4,0,1,2,3,4
shuzu_length      DWORD       9
zheng             WORD       4 DUP(?)
fu                WORD       4 DUP(?)
outputnum         BYTE        20 DUP(?)
huanhang          BYTE        cr,Lf
.CODE                           ; start of main program code
_start:
        LEA ESI, shuzu
        LEA EDI ,fu
        CLD
        MOV ECX, shuzu_length
loop1_start:                     ;负数
        LODSW
        CMP AX, 0;
        JGE NEXTa
        STOSW
NEXTa:
        LOOP loop1_start

        LEA ESI, shuzu
        LEA EDI ,zheng
        CLD
        MOV ECX, shuzu_length
loop2_start:
        LODSW
        CMP AX, 0
        JLE NEXTb                 ;正数
        STOSW
NEXTb:
        LOOP loop2_start


        LEA ESI, zheng
        CLD
        MOV ECX, 4
out_loop1:
        LODSW
        DTOA outputnum, EAX
        output outputnum
        LOOP out_loop1
        output huanhang


        LEA ESI, fu
        CLD
        mov ECX, 4
out_loop2:
        LODSW
        DTOA outputnum, EAX
        output outputnum
        LOOP out_loop2


        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

