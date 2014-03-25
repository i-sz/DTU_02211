#
# for DTU course 02211
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Example file
# Simple IS tests
#


addi r01,r00,2
#r00 = 0, r01 = 2
add r02,r01,r01
#r00 = 0, r01 = 2, r02 = 4
sub r03,r02,r01
#r00 = 0, r01 = 2, r02 = 4, r03 = 2
mult r04,r01,r02
#r00 = 0, r01 = 2, r02 = 4, r03 = 2, r04 = 8
div r05,r04,r01

and r06,r01,r02

or r07,r01,r02

slt r03,r02,r01

addi r01,r00,0

addi r02,r00,1

beq r01,r02,3

addi r01,r01,1

jmp -2

addi r01,r01,-1

sb r04,r00,255

lb r04,r00,255



