#
# for DTU course 02211
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Reverses text from memory point 1 to X to memory point X+1 - X+X+1
#
addi r01,r00,0
addi r02,r00,1
addi r03,r00,1
addi r12,r00,0
addi r13,r00,1
addi r14,r00,3
addi r15,r00,46
addi r27,r00,20
;h
START:
lb r11,r00,2
nop
nop
nop
nop
nop
beq r11,r13,START
nop
nop
nop
lb r10,r00,1
nop
nop
nop
nop
nop
beq r11,r12,START
nop
nop
beq r11,r15,GOOUTPUT
nop
nop
beq r01,r27,GOOUTPUT
nop
nop
addi r01,r01,1
addi r12,r11,0
nop
nop
nop
nop
nop
sb r10,r01,10
jmp START
nop
nop
nop

GOOUTPUT:
addi r16,r01,0
nop
nop
nop
nop
nop
jmp OUTPUT
nop
nop
nop
nop
OUTPUT:
lb r10,r01,10
sub r01,r01,r03
addi r20,r00,10000
nop
nop
nop
sb r10,r00,0
beq r00,r01,END
nop
nop
nop
jmp LOOP
nop
nop




LOOP:
beq r20,r00,OUTPUT
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
sub r20,r20,r03
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
jmp LOOP
nop
nop


nop
nop
END:
nop
nop