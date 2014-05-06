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
addi r01,r00,10
nop
addi r02,r00,0
nop
beq r01,r02,END
nop
addi r02,r02,1
nop
jmp START
END:
nop
nop
