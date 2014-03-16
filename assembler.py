# Simple assembler for DTU course 02211

import re

def convert_regs(regs):
    binary = ""
    for reg in regs:
        if re.search("r00", reg):
            binary = binary + "00000"
        elif re.search("r01", reg):
            binary = binary + "00001"
        elif re.search("r02", reg):
            binary = binary + "00010"
        elif re.search("r03", reg):
            binary = binary + "00011"
        elif re.search("r04", reg):
            binary = binary + "00100"
        elif re.search("r05", reg):
            binary = binary + "00101"
        elif re.search("r06", reg):
            binary = binary + "00110"
        elif re.search("r07", reg):
            binary = binary + "00111"
        else:
            return False
    return binary

def convert_imm(imm):
    binary = '{0:016b}'.format(int(imm))
    return binary

def convert_dst(dst):
    binary = '{0:026b}'.format(int(dst))
    return binary
    

def parse_reg(line):
    parts = line.split(" ")
    op = parts[0]
    regs = parts[1].split(",")
    shift_binary = "00000"
    op_binary = "000000"
    if re.search("add", op):
        funct_binary = "100000"
    elif re.search("sub", op):
        funct_binary = "100010"
    elif re.search("mult", op):
        funct_binary = "100100"
    elif re.search("div", op):
        funct_binary = "100101"
    elif re.search("and", op):
        funct_binary = "101000"
    elif re.search("or", op):
        funct_binary = "101001"
    elif re.search("slt", op):
        funct_binary = "110100"
    elif re.search("srl", op):
        funct_binary = "111000"
    elif re.search("slr", op):
        funct_binary = "111001"
    else:
        funct_binary = False
    reg_binary = convert_regs(regs)
    if reg_binary == False or funct_binary == False:
        binary = False
    else:
        binary = op_binary + reg_binary + shift_binary + funct_binary
    return binary



def parse_imm(line):
    parts = line.split(" ")
    op = parts[0]
    regs_imm = parts[1].split(",")
    regs = [regs_imm[0], regs_imm[1]]
    imm = regs_imm[2]
    if re.search("addi", op):
        op_binary = "001000"
    elif re.search("beq", op):
        op_binary = "000100"
    elif re.search("lb", op):
        op_binary = "100000"
    elif re.search("sb", op):
        op_binary = "101000"
    else:
        op_binary = False
    reg_binary = convert_regs(regs)
    imm_binary = convert_imm(imm)
    if reg_binary == False or imm_binary == False or op_binary == False:
        binary = False
    else:
        binary = op_binary + reg_binary + imm_binary
    return binary



def parse_jmp(line):
    parts = line.split(" ")
    op = parts[0]
    dst = parts[1]
    if re.search("jmp\s", op):
        op_binary = "001000"
    else:
        op_binary = False
    dst_binary = convert_dst(dst)
    if op_binary == False:
        binary = False
    else:
        binary = op_binary + dst_binary
    return binary

def check_line(line):
    reg_types=["add", "sub", "mult", "div", "and", "or", "slt", "srl", "slr"]
    imm_types=["addi", "beq", "lb", "sb"]
    jmp_types=["jmp"]

    if re.match("#", line):
        return False
    else:
        for reg in reg_types:
            if re.search(reg+"\s", line):
                binary = parse_reg(line)
        for imm in imm_types:
            if re.search(imm+"\s", line):
                binary = parse_imm(line)
        for jmp in jmp_types:
            if re.search(jmp+"\s", line):
                binary = parse_jmp(line)
        try:
            return binary
        except UnboundLocalError:
            return False


with open('IS.asm') as input_file:
    output = open('output.bin', 'wb')
    for line in input_file:
        binary = check_line(line.rstrip().lstrip())
        if binary != False:
            print binary
            output.write(binary)
    output.close()
