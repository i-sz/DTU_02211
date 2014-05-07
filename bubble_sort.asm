#
# for DTU course 02211
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Test file
#

INITIALIZE:
;Initialize some values
addi r01,r00,10
addi r02,r00,15
addi r03,r00,5
addi r04,r00,7
addi r05,r00,12
addi r06,r00,17
addi r07,r00,13
addi r08,r00,2
nop
nop
nop
nop
nop

;Store to memory
STORE:
sb r01,r00,11
sb r02,r00,12
sb r03,r00,13
sb r04,r00,14
sb r05,r00,15
sb r06,r00,16
sb r07,r00,17
sb r08,r00,18
nop
nop
nop
nop
nop


COUNTERS:
;Define last register slot
addi r09,r00,8
;Counter for MEM point
addi r10,r00,0
;Counter2
addi r11,r00,0
;Counter3
addi r12,r00,0
LOOP:
nop
nop
nop
nop
nop

lb r05,r10,11
nop
nop
nop
nop
nop
lb r06,r10,12
nop
nop
nop
nop
nop
addi r01,r05,0
addi r02,r06,0
nop
nop
nop
nop
nop
slt r03,r01,r02

nop
nop
nop
nop
nop
beq r03,r00,SWAP
SWAPPED:

beq r12,r09,END
nop
nop
nop
nop
nop
beq r10,r09,INC2
nop
nop
nop
jmp INC1
nop
nop


INC2:
nop
nop
nop
addi r12,r12,1
addi r10,r00,0
nop
nop
nop
nop
nop
jmp LOOP
nop
nop
nop

INC1:
nop
nop
nop
nop
addi r10,r10,1
nop
nop
nop
nop
nop
jmp LOOP
nop
nop

SWAP:
nop
nop
nop
nop
nop
sb r02,r10,11
nop
nop
sb r01,r10,12
nop
nop
nop
nop
nop
jmp SWAPPED
nop
nop


END:

nop
nop
nop
;addi r01,r00,1

