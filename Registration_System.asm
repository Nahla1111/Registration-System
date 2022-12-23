include emu8086.inc
.MODEL SMALL
.DATA   
        ;N    size  val
        SIZE EQU 10
        PROJ_NAME DB '________________Regestration system________________,$'
        ID_MSG DB 13, 10, 'Enter your ID:$'
        PASS_MSG DB 13, 10, 'Enter your Password:$'
        ID_ERROR_MSG DB 13, 10, 'ERROR ID not Found!$'
        PASS_ERRORMSG DB 13, 10, 'Wrong Password! Access denied$'
        SUCESS_REG DB 13, 10, 'Correct! Welocome to the Safe$'
        LONG_PASS DB 13, 10, 'Too Long password!$'
        INPUT_ID DW 1 DUP(?),0
        INPUT_Pass DB 1 DUP(?)
        IDSize = $-TEMP_ID
        PassSize = $-Temp_Pass
        ID  DW        'A150', 'B255', 'CE20', 'BB71', 'D111', 'E500', 'F432', 'EC12', '5321', '9876' 
        Password DB   1,      2,      3,      4,       7,     10,     11,     13,     12,      14
    
.CODE
MAIN        PROC 
            MOV AX,@DATA   
            MOV DS,AX
            MOV AX,0000H
            

Title:      LEA DX,PROJ_NAME
            MOV AH,09H
            INT 21H  
         

ID_PROMPT:  LEA DX,ID_MSG
            MOV AH,09H
            INT 21H
            
            
GET_ID:     MOV BX,0
            MOV DX,0
            LEA DI,INPUT_ID
            MOV DX,IDSize
            CALL get_string
            

CheckID:    MOV BL,0
            MOV SI,0

AGAIN:      MOV AX,ID[SI] 
            MOV DX,INPUT_ID
            CMP DX,AX
            JE  GET_PASS
            INC BL
            ADD SI,4
            CMP BL,SIZE
            JB  AGAIN
            
ERRORMSG:   LEA DX,ID_ERROR_MSG
            MOV AH,09H
            INT 21H
            JMP GET_ID
             
            
GET_PASS:   LEA DX,PASS_MSG
            MOV AH,09H
            INT 21H
            
Pass_INPUT: CALL   scan_num
            CMP    CL,0FH
            JAE    TooLong
            MOV    BH,00H
            MOV    DL,Password[BX]
            CMP    CL,DL
            JE     SUCSSEDED 

            
INCORRECT:  LEA DX,PASS_ERRORMSG
            MOV AH,09H
            INT 21H
            JMP ID_PROMPT
            
            
SUCSSEDED:  LEA DX,SUCESS_REG
            MOV AH,09H
            INT 21H
            JMP Terminate

            
TooLong:    LEA DX,LONG_PASS
            MOV AH,09H
            INT 21H
            JMP GET_PASS
            

DEFINE_SCAN_NUM
DEFINE_GET_STRING
Terminate: 
.exit
END MAIN     



