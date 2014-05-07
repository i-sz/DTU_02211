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

; Simple + and - actions
addi r01,r00,1
addi r02,r01,2
addi r03,r02,3
addi r04,r03,4
add r31,r01,r03
add r30,r31,r01
sub r31,r31,r02
sb r01,r00,1
sb r02,r00,2


; Multiplying
addi r01,r00,1
addi r02,r00,2
addi r03,r00,3
addi r04,r00,4
mult r31,r02,r02
mult r31,r02,r03

lb r01,r00,1
lb r02,r00,2

