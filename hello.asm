#
# for DTU course 02211
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Saves "Hello world!" to caches r01-r12 and stores it to memory address 0 (UART write)
#


addi r01,r00,72
#r01 = H
; sb r01,r00,0

addi r02,r00,101
#r02 = e
; sb r02,r00,0

addi r03,r00,108
#r03 = l
; sb r03,r00,0

addi r04,r00,108
#r04 = l
; sb r04,r00,0

addi r05,r00,111
#r05 = o
; sb r05,r00,0

addi r06,r00,32
#r06 = " "
; sb r06,r00,0

addi r07,r00,119
#r07 = w
; sb r07,r00,0

addi r08,r00,111
#r08 = o
; sb r08,r00,0

addi r09,r00,114
#r09 = r
; sb r09,r00,0

addi r10,r00,108
#r10 = l
; sb r10,r00,0

addi r11,r00,100
#r11 = d
; sb r11,r00,0

addi r12,r00,33
#r12 = !
; sb r12,r00,0

sb r01,r00,0
sb r02,r00,0
sb r03,r00,0
sb r04,r00,0
sb r05,r00,0
sb r06,r00,0
sb r07,r00,0
sb r08,r00,0
sb r09,r00,0
sb r10,r00,0
sb r11,r00,0
sb r12,r00,0

