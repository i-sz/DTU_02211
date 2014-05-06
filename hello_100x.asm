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

addi r31,r00,100
addi r30,r00,100
addi r29,r00,100
addi r28,r00,100
addi r27,r00,100
addi r26,r00,100
addi r25,r00,100
addi r24,r00,100
addi r23,r00,100
addi r22,r00,100
addi r21,r00,100
addi r20,r00,100

C1:
addi r31,r31,-1
beq r00,r31,C2
sb r01,r00,0
nop
C2:
addi r30,r30,-1
beq r00,r30,C3
sb r02,r00,0
nop
C3:
addi r29,r29,-1
beq r00,r29,C4
sb r03,r00,0
nop
C4:
addi r28,r28,-1
beq r00,r28,C5
sb r04,r00,0
nop
C5:
addi r27,r27,-1
beq r00,r27,C6
sb r05,r00,0
nop
C6:
addi r26,r26,-1
beq r00,r26,C7
sb r06,r00,0
nop
C7:
addi r25,r25,-1
beq r00,r25,C8
sb r07,r00,0
nop
C8:
addi r24,r24,-1
beq r00,r24,C9
sb r08,r00,0
nop
C9:
addi r23,r23,-1
beq r00,r23,C10
sb r09,r00,0
nop
C10:
addi r22,r22,-1
beq r00,r22,C11
sb r10,r00,0
nop
C11:
addi r21,r21,-1
beq r00,r21,C12
sb r11,r00,0
nop
C12:
addi r20,r20,-1
beq r00,r20,END
sb r12,r00,0
nop
END:
nop
jmp END
nop
