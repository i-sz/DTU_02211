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

;End of the line sign
;addi r03,r00,13
nop
nop
nop
nop
nop
sb r20,r00,5
nop
nop
nop
nop
nop
lb r10,r00,5
;addi r05,r00,5

;For minus things
;addi r04,r00,1

;Counter
;addi r01,r00,0

;h
;addi r06,r00,104

;Read loop start
;Read from UART
READUART:
nop
nop
nop
nop
nop
lb r10,r00,1
nop
nop
nop
nop
nop
beq r10,r06,READMEM
nop
nop
nop
nop
nop
jmp READUART
nop
nop
nop
beq r00,r10,READUART
nop
nop
nop
nop
nop

;Store to memory
sb r10,r01,2

;Check if line end
;beq r10,r03,READMEM
beq r01,r05,READMEM
nop
nop
nop
nop
nop

;Increase counter
addi r01,r01,1
nop
nop
nop
nop
nop
;Jump back to read more
jmp READUART
;Read loop end

nop
nop
nop
nop
nop

;Read backwards loop start
READMEM:
nop
nop
nop
nop
nop
lb r11,r01,2
OUTPUT:
nop
nop
nop
nop
nop

;Write to UART
sb r11,r00,0

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
nop
;Check if line end (counter is zero)
beq r01,r00,END
nop
nop
nop
nop
nop
;Decrease counter
sub r01,r01,r04
nop
nop
nop
nop
nop
jmp READMEM

END:

nop
nop
nop
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

