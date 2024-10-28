    .ORIG x3000
    
; Name: Lonoehu Wacasey
; Date: 10/27/24
; Lab #3
;
;

; BLOCK 1
; Register R0 is loaded with x4000, which will serve as a pointer to the numbers.
;  

	LD R0,PTR
    LD R4, CODECHK
    AND R5, R5, #0
    
ARRAYCNTR
    LDR R1, R0, #0
    AND R2, R1, R4
    BRZ OUTLOOP
    ADD R5, R5, #1
    ADD R0, R0, #1
    BR ARRAYCNTR

OUTLOOP
    ADD R5, R5, #-1
    BRNZ DONE
    ST R5, ANUM
    LD R6, ANUM
    LD R0, PTR
    BR MAINLOOP
    
MAINLOOP
    LDR R1, R0, #0
    LDR R2, R0, #1
    JSR ARRANGE
    ADD R3, R3, #0
    BRN NOCHNGE
    BR POSSUM
    
POSSUM
    STR R1, R0, #1
    STR R2, R0, #0
    BR NOCHNGE
    
NOCHNGE
    ADD R0, R0, #1
    ADD R6, R6, #-1
    BRZ OUTlOOP
    BR MAINLOOP
    
;Block 2
;This is where the main JSR for Compare is
;Inputs are R1 and R2, with output being R3

ARRANGE
   ST R1, SAVER1
   ST R2, SAVER2
   ST R4, SAVER4
   ST R5, SAVER5
   ST R6, SAVER6
   ST R7, SAVER7
   
   AND R3, R3, #0
   JSR SHIFT1
   JSR SHIFT2
   
   NOT R2, R2
   ADD R2, R2, #1
   ADD R1, R1, R2
   BRN NEGATIVE
   ADD R3, R3, #1
   BR RELD
   
NEGATIVE
    ADD R3, R3, #-1
    BR RELD
    
RELD
   LD R1, SAVER1
   LD R2, SAVER2
   LD R4, SAVER4
   LD R5, SAVER5
   LD R6, SAVER6
   LD R7, SAVER7
   RET


;Block 2
; In this block, the shifting code is included
;Inputs: R1, R2     OUtputs: R1, R2

SHIFT1
    ST R7, SHIFTSAVE
    AND R4, R4, #0
    LD R4, MASK
    AND R1, R1, R4
    ADD R3, R3, #8  ;r3 designated as a counter to count the shifts we need to make
    AND R4, R4, #0
    LD R4, OFCHK    ;clears r4 and loads in a number which we can use to detect overflow
    BR RGHTSHFT
RGHTSHFT
    AND R7, R7, #0
    AND R7, R4, R1  ;clears r5 and then checks if rightmost value of number 2 is a 1
    BRZ NOONE
    BR  HAYONE
NOONE
    ADD R1, R1, R1  ;if no 1 in the MSB, we shift the values of number 2 to the right, causing a 0 in the LSB
    BR COUNTER
HAYONE
    ADD R1, R1, R1  ;if there is a 1 in the MSB, we shift number 2 to the right and then add 1
    ADD R1, R1, #1
    BR COUNTER
COUNTER
    ADD R3, R3, #-1 ;negates counter by 1, if we are down to zero, we have fully shifted the number, otherwise restart
    BRZ COMEBACK
    BR RGHTSHFT
COMEBACK
    LD R7, SHIFTSAVE
    RET





SHIFT2
    ST R7, SHIFTSAVE
    AND R7, R7, #0
    AND R4, R4, #0
    LD R4, MASK
    AND R2, R2, R4
    ADD R3, R3, #8  ;r3 designated as a counter to count the shifts we need to make
    AND R4, R4, #0
    LD R4, OFCHK   ;clears r4 and loads in a number which we can use to detect overflow
RGHTSHFT2
    AND R7, R7, #0
    AND R7, R4, R2  ;clears r5 and then checks if rightmost value of number 2 is a 1
    BRZ NOONE2
    BR  HAYONE2
NOONE2
    ADD R2, R2, R2  ;if no 1 in the MSB, we shift the values of number 2 to the right, causing a 0 in the LSB
    BR COUNTER2
HAYONE2
    ADD R2, R2, R2  ;if there is a 1 in the MSB, we shift number 2 to the right and then add 1
    ADD R2, R2, #1
    BR COUNTER2
COUNTER2
    ADD R3, R3, #-1 ;negates counter by 1, if we are down to zero, we have fully shifted the number, otherwise restart
    BRZ COMEBACK2
    BR RGHTSHFT2
COMEBACK2
    LD R7, SHIFTSAVE
    RET




DONE
    HALT
    
    
PTR .FILL x4000
ANUM .BLKW x1

SHIFTSAVE  .BLKW x1

SAVER1  .BLKW x1
SAVER2  .BLKW x1
SAVER3  .BLKW x1
SAVER4  .BLKW x1
SAVER5  .BLKW x1
SAVER6  .BLKW x1
SAVER7  .BLKW x1


MASK	.FILL	xFF00
CODECHK .FILL   x00FF
OFCHK   .FILL   x8000

    .END

