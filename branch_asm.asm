#
# for DTU course 02211
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Simple additions and subtractions
#

; Simple + and - actions
START:
nop
addi r01,r01,10
nop
addi r02,r00,0
nop
nop
nop
nop
nop
LOOP:
beq r01,r02,LOOP2IN
nop
nop
nop
nop
nop
sb r02,r02,0
addi r02,r02,1
nop
jmp LOOP
nop
nop
nop
LOOP2IN:
addi r03,r02,0
addi r02,r00,0
nop
nop
nop
nop
nop
LOOP2:
beq r02,r03,END
nop
nop
nop
nop
nop
lb r04,r02,0
addi r02,r02,1
nop
nop
nop
jmp LOOP2
nop
nop
END:
nop
nop
