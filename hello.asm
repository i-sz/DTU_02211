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
nop
nop
nop
addi r21,r00,1

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
START:
H:
addi r20,r00,10000
sb r01,r00,0
jmp LOOP2
nop
nop
E:
addi r20,r00,10000
sb r02,r00,0
jmp LOOP3
nop
nop
L:
addi r20,r00,10000
sb r03,r00,0
jmp LOOP4
nop
nop
L2:
addi r20,r00,10000
sb r04,r00,0
jmp LOOP5
nop
nop
O:
addi r20,r00,10000
sb r05,r00,0
jmp LOOP6
nop
nop
S:
addi r20,r00,10000
sb r06,r00,0
jmp LOOP7
nop
nop
W:
addi r20,r00,10000
sb r07,r00,0
jmp LOOP8
nop
nop
O2:
addi r20,r00,10000
sb r08,r00,0
jmp LOOP9
nop
nop
R:
addi r20,r00,10000
sb r09,r00,0
jmp LOOP10
nop
nop
L3:
addi r20,r00,10000
sb r10,r00,0
jmp LOOP11
nop
nop
D:
addi r20,r00,10000
sb r11,r00,0
jmp LOOP12
nop
nop
EX:
addi r20,r00,10000
sb r12,r00,0
nop
jmp END
nop
nop
nop
nop
INITCOUNTER:
addi r20,r00,10000
addi r21,r00,1
LOOP1:
beq r20,r00,H
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP1
nop
nop
LOOP2:
beq r20,r00,E
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP2
nop
nop
LOOP3:
beq r20,r00,L
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP3
nop
nop
LOOP4:
beq r20,r00,L2
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP4
nop
nop
LOOP5:
beq r20,r00,O
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP5
nop
nop
LOOP6:
beq r20,r00,S
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP6
nop
nop
LOOP7:
beq r20,r00,W
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP7
nop
nop
LOOP8:
beq r20,r00,O2
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP8
nop
nop
LOOP9:
beq r20,r00,R
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP9
nop
nop
LOOP10:
beq r20,r00,L3
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP10
nop
nop
LOOP11:
beq r20,r00,D
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP11
nop
nop
LOOP12:
beq r20,r00,EX
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
sub r20,r20,r21
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
jmp LOOP12
nop
nop
END:
nop
;jmp START
nop
