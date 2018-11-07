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
array_length    DWORD   5
array           WORD   12,35,45,6,23
key_word        WORD   23
prompt1         BYTE   "200 Found!",0
prompt2         BYTE   "404 Not Found!",0
.CODE                           ; start of main program code
Search PROC NEAR32
        MOV EBP,ESP
        ADD EBP, 4
        PUSH ECX
        PUSH EDI
        PUSH EAX
        MOV ECX, [EBP]    ; mov length
        MOV EDI, [EBP+4]  ; mov string head pointer
        MOV AX, [EBP+8]
        CLD
        REPNE SCASW
        JNZ NOT_FOUND
        output prompt1
        jmp END_SEARCH
        NOT_FOUND:
        output prompt2
        END_SEARCH:
        POP EAX
        POP EDI
        POP ECX
        RET 10
Search ENDP
_start:
    lea eax, array
    push key_word
    push eax
    push array_length
    call Search
        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

