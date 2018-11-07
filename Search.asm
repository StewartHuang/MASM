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
outputnumber    BYTE    11 dup(?)
array_length    DWORD   10
array           DWORD   1,2,3,4,5,6,7,8,9,0
key_word        DWORD   100
.CODE                           ; start of main program code
Search PROC NEAR32
        MOV EBP,ESP
        ADD EBP, 4
        PUSH ECX
        PUSH EBX
        PUSH EDX
        MOV ECX, [EBP]
        MOV EBX, [EBP+4]
        MOV EDX, [EBP+8]
        START_SEARCH:
        CMP EDX, [EBX]
        JE SEARCH_SUCCESS
        ADD EBX, 4
        LOOP START_SEARCH
        MOV EAX, 0
        JMP END_SEARCH
        SEARCH_SUCCESS:
        MOV EAX, [EBP]
        SUB EAX, ECX
        inc eax
        END_SEARCH:
        POP EDX
        POP EBX
        POP ECX
        RET 12
Search ENDP
_start:
    lea eax, array
    push key_word
    push eax
    push array_length
    call Search
    dtoa outputnumber, eax
    output outputnumber
        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

