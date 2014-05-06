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
addi r02,r00,101
addi r03,r00,108
addi r04,r00,108
addi r05,r00,111
addi r06,r00,32
addi r07,r00,119
addi r08,r00,111
addi r09,r00,114
addi r10,r00,108
addi r11,r00,100
addi r12,r00,33

addi r31,r00,0
addi r30,r00,0
addi r29,r00,0
addi r28,r00,0
addi r27,r00,0
addi r26,r00,0
addi r25,r00,0
addi r24,r00,0
addi r23,r00,0
addi r22,r00,0
addi r21,r00,0
addi r20,r00,0
addi r19,r00,100
nop
nop
nop
nop
nop

C1:
sb r01,r00,0
nop
sb r02,r00,0
nop
sb r03,r00,0
nop
sb r04,r00,0
nop
sb r05,r00,0
nop
sb r06,r00,0
nop
sb r07,r00,0
nop
sb r08,r00,0
nop
sb r09,r00,0
nop
sb r10,r00,0
nop
sb r11,r00,0
nop
sb r12,r00,0
nop
nop
nop
nop
nop
;jmp C1

nop
nop
nop
nop
nop
nop
END:
nop
nop
