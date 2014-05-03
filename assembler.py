#
#
# Programmed for Python 2.7.X
# Simple assembler for DTU course 02211
#
#
# Project by:
# Harri Antero Laine: s131196
# Istvan Szonyi: s131153
# Komlan Tom Evon: s072728
#
#
# Instruction set:
# https://en.wikiversity.org/wiki/Computer_Architecture_Lab/SS2014/group_5_lab_2
#

import sys
import re

firstRun = True
cmdLineNumber = 0
points = {}

#Calculates two's complement from a binary string
#and returns it
def twos_comp(binary):
    binary = list(binary)
    #Flip bits from 1 to 0 and from 0 to 1
    for i in range(0,len(binary)):
        if binary[i] == "0":
            binary[i] = "1"
        else:
            binary[i] = "0"
    #Add 1 to result
    for i in range(len(binary)-1,-1,-1):
        if binary[i] == "1":
            binary[i] = "0"
        else:
            binary[i] = "1"
            break
    #Reconstruct string
    binary_ret = ""
    for i in range(0,len(binary)):
        binary_ret = binary_ret + binary[i]
    return binary_ret
    

def convert_regs(regs):
    binary = ""
    for reg in regs:
        m = re.search("r([0-9]*)", reg)
        if m:
            # 5-bit regs, between 0 and 2^5
            if int(m.group(1)) >= 0 and int(m.group(1)) < pow(2,5):
                binary = binary + '{0:05b}'.format(int(m.group(1)))
            else:
                return False
        else:
            return False
    return binary

def convert_imm(imm):
    imm = int(imm)
    binary = ""
    # 16-bit imm-value so between -2^15 and 2^15 (signed value)
    if imm > -pow(2,15) and imm < pow(2,15):
        binary = binary + '{0:016b}'.format(abs(imm))
        if imm < 0:
            binary = twos_comp(binary)
    else:
        return False
    # print binary
    return binary

def convert_imm_dst(dst):
    global points
    global cmdLineNumber
    #print "BEQ: Line: " + str(cmdLineNumber) + " - dst: " + str(points[dst])
    dst = points[dst] - cmdLineNumber
    #print dst
    dst = int(dst)
    if dst < 0:
        dst = dst - 1
    binary = ""
    # 16-bit imm value so between -2^15 and 2^15 (signed value)
    if dst > -pow(2,15) and dst < pow(2,15):
        binary = binary + '{0:016b}'.format(abs(dst))
        if dst < 0:
            binary = twos_comp(binary)
    else:
        return False
    #print binary
    return str(binary)

def convert_dst(dst):
    global points
    global cmdLineNumber
    #print "JMP: Line: " + str(cmdLineNumber) + " - dst: " + str(points[dst])
    dst = points[dst] - cmdLineNumber
    #print dst
    dst = int(dst)
    if dst < 0:
        dst = dst - 1
    binary = ""
    # 26-bit dst value so between -2^25 and 2^25 (signed value)
    if dst > -pow(2,25) and dst < pow(2,25):
        binary = binary + '{0:026b}'.format(abs(dst))
        if dst < 0:
            binary = twos_comp(binary)
    else:
        return False
    #print binary
    return str(binary)
    

def parse_reg(line):
    parts = line.split(" ")
    op = parts[0]
    shift_binary = "00000"
    op_binary = "000000"
    if re.search("nop", op):
        funct_binary = "000000"
        reg_binary = "000000000000000"
    else:
        regs = parts[1].split(",")
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
        return False
    else:
        binary = op_binary + reg_binary + shift_binary + funct_binary
    return binary



def parse_imm(line):
    parts = line.split(" ")
    op = parts[0]
    regs_imm = parts[1].split(",")
    regs = [regs_imm[0], regs_imm[1]]
    imm = regs_imm[2]
    imm_binary = None
    if re.search("addi", op):
        op_binary = "100001"
    elif re.search("beq", op):
        op_binary = "000010"
        imm_binary = convert_imm_dst(imm)
    elif re.search("lb", op):
        op_binary = "100000"
    elif re.search("sb", op):
        op_binary = "110000"
    else:
        op_binary = False
    reg_binary = convert_regs(regs)
    if imm_binary == None:
        imm_binary = convert_imm(imm)
    if reg_binary == False or imm_binary == False or op_binary == False:
        return False
    else:
        binary = op_binary + reg_binary + imm_binary
    return binary



def parse_jmp(line):
    parts = line.split(" ")
    op = parts[0]
    dst = parts[1]
    if re.search("jmp", op):
        op_binary = "000001"
    else:
        op_binary = False
    dst_binary = convert_dst(dst)
    if op_binary == False or dst_binary == False:
        binary = False
    else:
        binary = op_binary + dst_binary
    return binary

def parse_points(line):
    global points
    global cmdLineNumber
    parts = line.split(":")
    point = parts[0]
    points[point] = cmdLineNumber
    return True

#Check line operation type
def parse_line(line):
    global firstRun
    global cmdLineNumber
    reg_types=["add", "sub", "mult", "div", "and", "or", "slt", "srl", "slr", "nop"]
    imm_types=["addi", "beq", "lb", "sb"]
    jmp_types=["jmp"]

    if firstRun == True:
        if re.search("[a-zA-Z0-9]:$", line):
            #print "FOUND"
            return not parse_points(line)
    #Commented lines start with # or ;
    if re.match("#", line):
        return False
    elif re.match(";", line):
        return False
    else:
        #Registry-type ops
        for reg in reg_types:
            if re.search(reg+"\s", line) or re.search(reg+"$", line):
                if firstRun == True:
                    return "00000000000000000000000000000000"
                binary = parse_reg(line)
        #Immediate-type ops
        for imm in imm_types:
            if re.search(imm+"\s", line):
                if firstRun == True:
                    return "00000000000000000000000000000000"
                binary = parse_imm(line)
        #Jump-type ops
        for jmp in jmp_types:
            if re.search(jmp+"\s", line):
                if firstRun == True:
                    return "00000000000000000000000000000000"
                binary = parse_jmp(line)
        #Check if binary is defined
        try:
            if binary == False:
                raise NameError('Something wrong with line ' + line)
            return binary
        except UnboundLocalError:
            return False

#Main program
def main(argv):
    global cmdLineNumber
    global firstRun
    if (len(argv) == 0):
        print "Give assembly file as a parameter"
        exit(0)
    print "Running with file " + str(argv[0]) + "..."
    #Read input file
    with open(argv[0]) as input_file:
        #Open output file
        #output = open(input_file.name.rsplit(".", 1)[0] + ".bin", 'wb')
        output_lines = open(input_file.name.rsplit(".", 1)[0] + "_lines.bin", 'wb')
        for i in range(0, 2):
            cmdLineNumber = 0
            #Read file line by line
            for line in input_file:
                #Strip empty characters from left and right
                binary = parse_line(line.rstrip().lstrip())
                #If there is no errors parsing code, output it
                if binary != False:
                    if len(binary) == 32:
                        cmdLineNumber = cmdLineNumber + 1
                        #Print output
                        if firstRun == False:
                            print "       when 4*" + str(cmdLineNumber-1) + "   => data <= \"" + binary + "\"; -- " + str(line.rstrip().lstrip())
                            #Write output to file
                            #output.write(binary)
                            if (cmdLineNumber-1) < 10:
                                space = " "
                            else:
                                space = ""
                            output_lines.write("       when 4*" + str(cmdLineNumber-1) + "   "+space+"=> data <= \"" + binary + "\"; -- " + str(line.rstrip().lstrip()) + "\n")
                    else:
                        print "Error!!"
                        exit(0)
            input_file.seek(0, 0)
            firstRun = False
        #Close output file
        #output.close()
    #Program finished
    print "Finished"

# Run main
if __name__ == "__main__":
    main(sys.argv[1:])
