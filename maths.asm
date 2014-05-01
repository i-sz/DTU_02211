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
addi r01,r00,1
addi r02,r00,2
addi r03,r00,3
addi r04,r00,4
add r31,r00,r03
add r31,r31,r01
sub r31,r31,r02


; Multiplying
addi r01,r00,1
addi r02,r00,2
addi r03,r00,3
addi r04,r00,4
mult r31,r02,r02
mult r31,r02,r03