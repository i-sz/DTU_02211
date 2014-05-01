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

;# Initialize counter
addi r01,r00,1
;# End of string character (Carriage return)
addi r03,r00,13
;# GETLENGTH
;# Read from counter point mem
ld r02,r01,00
;# Skip to READANDREVERSE if Carriage return
beq r02,r03,3
;# Increase counter r01
addi r01,r01,1
;# Jump back to GETLENGTH
jmp -3
;# READANDREVERSE
;# END OF getting string length
;# String length in r01
;# Starting point for writing mem in r04
addi r04,r01,1
;# Starting point for reversed string initialized in r05
add r05,r04,r00
;#start position for mem in r04 anr r05
;#READWRITE
; Load from the end of the string to r10 (r01 is the last char at first)
ld r10,r01,0
; Decrease counter r01
addi r01,r01,-1
; Store r10 to a new memory point r04
sb r10,r04,0
; Increase counter r04
addi r04,r04,1
; Skip to loading characters to a r31 (LOADTO31) if Carriage return
beq r10,r03,2
; Jump back to READWRITE
jmp -5
; LOADTO31
;# put to r31 where it will be outputted
ld r31,r05,0
; Increase counter r05
addi r05,r05,1
; Skip to END if Carriage return
beq r31,r03,1
; Jump back to LOADTO31
jmp -3
;END

