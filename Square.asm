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
number   BYTE  20 DUP (?)
prompt1  BYTE  "Input N: ",0
value    BYTE  20 DUP (?)
         BYTE  cr
square   BYTE  20 DUP (?)
string1  BYTE  Lf,0


.CODE                             ; start of main program code
_start:
output  prompt1
input   number,20
atod    number
mov     ecx,eax
mov     ebx,1
L1:
mov     eax,ebx
mul     ebx
dtoa    value,ebx
output  value
dtoa    square,eax
output  square
output  string1
inc     ebx
loop L1
        INVOKE  ExitProcess, 0  ; exit with return code 0
PUBLIC _start                   ; make entry point public

END                             ; end of source code

