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

INITCOUNTER:
addi r20,r00,2
addi r21,r00,1
addi r22,r00,0

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
;Define number of numbers -2
addi r09,r00,6
;Counter for MEM point
addi r10,r00,0
;Define number of numbers
addi r11,r00,8
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
nop
nop
SWAPPED:

beq r12,r11,END
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
addi r22,r00,0
nop
nop
nop
nop
nop
jmp OUTPUT
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

OUTPUT:
O1:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP1
nop
nop
nop
nop
nop
O2:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP2
nop
nop
nop
nop
nop
O3:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP3
nop
nop
nop
nop
nop
O4:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP4
nop
nop
nop
nop
nop
O5:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP5
nop
nop
nop
nop
nop
O6:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP6
nop
nop
nop
nop
nop
O7:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP7
nop
nop
nop
nop
nop
O8:
addi r22,r22,1
nop
nop
nop
nop
nop
lb r30,r22,10
nop
nop
nop
nop
nop
addi r20,r00,2
sb r30,r00,0
jmp LOOP8
nop
nop
nop
nop
nop
;end of line (carriage return)
O9:
addi r23,r00,13
nop
nop
nop
nop
nop
addi r20,r00,2
sb r23,r00,0
jmp LOOP9
nop
nop
nop
nop
nop
nop
nop

LOOP1:
beq r20,r00,O2
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP1
nop
nop

LOOP2:
beq r20,r00,O3
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP2
nop
nop

LOOP3:
beq r20,r00,O4
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP3
nop
nop

LOOP4:
beq r20,r00,O5
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP4
nop
nop

LOOP5:
beq r20,r00,O6
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP5
nop
nop

LOOP6:
beq r20,r00,O7
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP6
nop
nop

LOOP7:
beq r20,r00,O8
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP7
nop
nop

LOOP8:
beq r20,r00,O9
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP8
nop
nop

LOOP9:
beq r20,r00,LOOP
nop
nop
sub r20,r20,r21
nop
nop
jmp LOOP9
nop
nop

END:

nop
nop
nop
;addi r01,r00,1

