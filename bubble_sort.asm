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

COUNTERS:
;Define last register slot
addi r09,r00,8
;Counter
addi r10,r00,0
;Counter2
addi r11,r00,0


LOOP:
addi r10,r10,1
nop
nop
nop
nop
nop
lb r01,r10,10
lb r02,r10,11

nop
nop
nop
nop
nop

slt r03,r01,r02

beq r11,r09,END

addi r11,r11,1

beq r03,r00,LOOP
jmp SWAP


SWAP:
addi r03,r01,0
nop
nop
nop
nop
nop
addi r01,r02,0
nop
nop
nop
nop
nop
addi r02,r03,0
nop
nop
nop
nop
nop
jmp LOOP


END:



