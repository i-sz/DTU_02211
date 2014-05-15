#
# for DTU course 02211
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Reverses text from memory point 1 to X to memory point X+1 - X+X+1
#
addi r15,r00,0
addi r17,r00,1
addi r07,r00,16
addi r08,r00,0
addi r09,r00,48

addi r25,r00,1
addi r26,r00,2
addi r27,r00,3

;h
addi r01,r00,104
#r01 = H
; sb r01,r00,0

addi r02,r00,101
#r02 = e
; sb r02,r00,0

addi r03,r00,108
#r03 = l
; sb r03,r00,0

addi r04,r00,108
#r04 = l
; sb r04,r00,0

addi r05,r00,111
#r05 = o
; sb r05,r00,0

;Read loop start
;Read from UART
READUART:
addi r20,r00,10000
nop
nop
nop
lb r11,r00,2
nop
nop
nop
nop
nop
beq r11,r25,READUART
nop
nop
nop
addi r15,r15,1
lb r10,r00,1
nop
nop
nop
nop
nop
sb r10,r00,0
nop
nop
nop
nop
nop
sb r10,r15,2
;beq r10,r09,GOOUTPUT
nop
nop
beq r15,r07,GOOUTPUT
nop
nop
jmp READUART
nop
nop
nop
; beq r10,r01,H
; nop
; nop
; beq r10,r02,E
; nop
; nop
; beq r10,r03,L
; nop
; nop
; beq r10,r05,O
; nop
; nop
; jmp READUART
; nop
; nop
; nop
; H:
; addi r15,r15,1
; sb r10,r15,2
; jmp READUART
; nop
; nop
; E:
; addi r15,r15,1
; sb r10,r15,2
; jmp READUART
; nop
; nop
; L:
; beq r08,r00,L2
; nop
; nop
; nop
; addi r15,r15,1
; sb r10,r15,2
; jmp READUART
; nop
; nop
; L2:
; addi r08,r08,1
; addi r15,r15,1
; sb r10,r15,2
; jmp READUART
; nop
; nop
; O:
; addi r15,r15,1
; sb r10,r15,2
; addi r16,r15,0
GOOUTPUT:
addi r16,r15,0
nop
nop
nop
nop
nop
jmp OUTPUT
nop
nop
nop
nop
; nop
; jmp LOOP2
; nop
; nop
; nop
; OUTPUT:
; addi r20,r00,10000
OUTPUT:
lb r10,r16,2
sub r16,r16,r17
addi r20,r00,10000
nop
nop
nop
sb r10,r00,0
beq r10,r09,END
nop
nop
nop
jmp LOOP
nop
nop

; ;Store to memory
; sb r10,r01,2

; ;Check if line end
; ;beq r10,r03,READMEM
; beq r01,r05,READMEM
; nop
; nop
; nop
; nop
; nop

; ;Increase counter
; addi r01,r01,1
; nop
; nop
; nop
; nop
; nop
; ;Jump back to read more
; jmp READUART
; ;Read loop end

; nop
; nop
; nop
; nop
; nop

; ;Read backwards loop start
; READMEM:
; nop
; nop
; nop
; nop
; nop
; lb r11,r01,2
; OUTPUT:
; nop
; nop
; nop
; nop
; nop

; ;Write to UART
; sb r11,r00,0

; nop
; nop
; nop
; nop
; nop
; jmp OUTPUT
; nop
; nop
; nop
; nop
; nop
; ;Check if line end (counter is zero)
; beq r01,r00,END
; nop
; nop
; nop
; nop
; nop
; ;Decrease counter
; sub r01,r01,r04
; nop
; nop
; nop
; nop
; nop
; jmp READMEM

; END:

; nop
; nop
; nop
; nop
; nop



LOOP:
beq r20,r00,OUTPUT
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r17
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP
nop
nop


nop
nop
END:
nop
nop
; ;# Initialize counter
; addi r01,r00,2
; ;# End of string character (Carriage return)
; addi r03,r00,13
; ;# GETLENGTH
; ;# Read from counter point mem
; lb r02,r01,00
; ;# Skip to READANDREVERSE if Carriage return
; beq r02,r03,3
; ;# Increase counter r01
; addi r01,r01,1
; ;# Jump back to GETLENGTH
; jmp -3
; ;# READANDREVERSE
; ;# END OF getting string length
; ;# String length in r01
; ;# Starting point for writing mem in r04
; addi r04,r01,1
; ;# Starting point for reversed string initialized in r05
; add r05,r04,r00
; ;#start position for mem in r04 anr r05
; ;#READWRITE
; ; Load from the end of the string to r10 (r01 is the last char at first)
; lb r10,r01,0
; ; Decrease counter r01
; addi r01,r01,-1
; ; Store r10 to a new memory point r04
; sb r10,r04,0
; ; Increase counter r04
; addi r04,r04,1
; ; Skip to loading characters to a r31 (LOADTO31) if Carriage return
; beq r10,r03,2
; ; Jump back to READWRITE
; jmp -5
; ; LOADTO31
; ;# put to r31 where it will be outputted
; lb r31,r05,0
; ; Increase counter r05
; addi r05,r05,1
; ; Skip to END if Carriage return
; beq r31,r03,1
; ; Jump back to LOADTO31
; jmp -3
; ;END

