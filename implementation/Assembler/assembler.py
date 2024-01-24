import re

#input: source_file
#pseudos: pseduoInstructionFile
#output: write_file_path

input_file = "assemblyCode.txt"
output_file = "machineCodeOutput.txt"
pseudoInstructionFile = "pseudoReplacement.txt"
pseudoNoLabel = "no_label_with_pseudo.txt"
assemblyWithoutPseudo = "assemblyReplacedPseudo.txt"
assemblyNoTag = "branchLabelAssembly.txt"

first_dict = {}
label_dict = {}

def convertToMachineCode(assemblyLine, j):
    assemblerSplit = re.split(r" |, |\(|\)", assemblyLine)
    args = []
    for i in range(len(assemblerSplit)):
        if (assemblerSplit[i] != ""):
            args.append(assemblerSplit[i])
    rd = ""
    rs1 = ""
    rs2 = ""
    imm = ""
    opcode = ""

    #R-Type
    if(args[0] == "add"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "0000"
        rd = getReg(args[1])
        rs1 = getReg(args[2])
        rs2 = getReg(args[3])
    elif(args[0] == "sub"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "0001"
        rd = getReg(args[1])
        rs1 = getReg(args[2])
        rs2 = getReg(args[3])
    elif(args[0] == "and"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "0010"
        rd = getReg(args[1])
        rs1 = getReg(args[2])
        rs2 = getReg(args[3])
    elif(args[0] == "or"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "0011"
        rd = getReg(args[1])
        rs1 = getReg(args[2])
        rs2 = getReg(args[3])

    #I-Type
    elif(args[0] == "addi"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "0100"
        rd = getReg(args[1])
        rs1 = getReg(args[2])
        imm = str(decimal_to_signed_binary(int(args[3]), 4))
    elif(args[0] == "lw"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "0111"
        rd = getReg(args[1])
        imm = str(decimal_to_signed_binary(int(args[2]), 4))
        rs1 = getReg(args[3])
    elif(args[0] == "sw"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "1000"
        rd = getReg(args[1])
        imm = str(decimal_to_signed_binary(int(args[2]), 4))
        rs1 = getReg(args[3])
    #check
    elif(args[0] == "jalr"):
        if(len(args) != 4):
            raise Exception('Invalid arguments')
        opcode = "1101"
        rd = getReg(args[1])
        imm = str(decimal_to_signed_binary(int(args[2]), 4))
        rs1 = getReg(args[3])
    #U-Type
    elif(args[0] == "beq"):
        if(len(args) != 3):
            raise Exception('Invalid arguments')
        opcode = "1001"
        rd = getReg(args[1])
        if args[2] in label_dict:
            instrOffset = -(((j - label_dict[args[2]])*2)+2)
            print("instruction at line: " + str(j))
            print("label at line: " + str(label_dict[args[2]]))
            imm = str(decimal_to_signed_binary(instrOffset, 8))
        else:    
            imm = str(decimal_to_signed_binary(int(args[2]), 8))
    elif(args[0] == "jal"):
        if(len(args) != 3):
            raise Exception('Invalid arguments')
        opcode = "1100"
        rd = getReg(args[1])
        if args[2] in label_dict:
            instrOffset = -(((j - label_dict[args[2]])*2)+2)
            print("instruction at line: " + str(j))
            print("label at line: " + str(label_dict[args[2]]))
            imm = str(decimal_to_signed_binary(instrOffset, 8))
        else:    
            imm = str(decimal_to_signed_binary(int(args[2]), 8))
    elif(args[0] == "lui"):
        if(len(args) != 3):
            raise Exception('Invalid arguments')
        opcode = "1110"
        rd = getReg(args[1])
        imm = str(decimal_to_signed_binary(int(args[2]), 8))
    elif(args[0] == "lbi"):
        if(len(args) != 3):
            raise Exception('Invalid arguments')
        opcode = "1111"
        rd = getReg(args[1])
        imm = str(decimal_to_signed_binary(int(args[2]), 8))
    #!!!
    elif(args[0] == "si"):
        if(len(args) != 3):
            raise Exception('Invalid arguments')
        opcode = "0101"
        rd = getReg(args[1])
        if(len(args[2]) != 8):
            raise Exception('shift immediate needs to be an 8 bit binary number')
        imm = args[2]
    elif(args[0] == "Lin"):
        if(len(args) != 2):
            raise Exception('Invalid arguments')
        opcode = "0110"
        rd = getReg(args[1])
        imm = "00000000"
    elif(args[0] == "Lout"):
        if(len(args) != 2):
            raise Exception('Invalid arguments')
        opcode = "1010"
        rd = "0000"
        rs1 = getReg(args[1])
        rs2 = "0000"
    else:
        raise Exception('Not a core instruction')
    #end
    instr = rd + rs1 + rs2 + imm + opcode
    return instr


def getReg(reg):
    if reg == "r0" or reg == "x0" or reg == "zero":
        return "0000"
    elif reg == "r1" or reg == "x1" or reg == "ra":
        return "0001"
    elif reg == "r2" or reg == "x2" or reg == "sp":
        return "0010"
    elif reg == "r3" or reg == "x3" or reg == "a0":
        return "0011"
    elif reg == "r4" or reg == "x4" or reg == "a1":
        return "0100"   
    elif reg == "r5" or reg == "x5" or reg == "a2":
        return "0101"    
    elif reg == "r6" or reg == "x6" or reg == "a3":
        return "0110"
    elif reg == "r7" or reg == "x7" or reg == "a4":
        return "0111"
    elif reg == "r8" or reg == "x8" or reg == "s0":
        return "1000"
    elif reg == "r9" or reg == "x9" or reg == "s1":
        return "1001"   
    elif reg == "r10" or reg == "x10" or reg == "s2":
        return "1010"
    elif reg == "r11" or reg == "x11" or reg == "t0":
        return "1011"
    elif reg == "r12" or reg == "x12" or reg == "t1":
        return "1100"  
    elif reg == "r13" or reg == "x13" or reg == "t2":
        return "1101" 
    elif reg == "r14" or reg == "x14" or reg == "br":
        return "1110" 
    elif reg == "r15" or reg == "x15" or reg == "at":
        return "1111"   

def decimal_to_signed_binary(decimal_value, num_bits):
    if not (-2 ** (num_bits - 1) <= decimal_value < 2 ** (num_bits - 1)):
        raise ValueError("Decimal value is out of range for the specified number of bits")
    if decimal_value >= 0:
        binary_value = bin(decimal_value)[2:].zfill(num_bits)
    else:
        binary_value = bin(2 ** num_bits + decimal_value)[2:]

    return binary_value


def write_string_to_file(file_path, input_string):
    try:
        with open(file_path, "a") as file:
            file.write(input_string + "\n")
    except Exception as e:
        print(f"An error  in writing to the file: {str(e)}")

def convert():
    with open(assemblyNoTag, "r") as file:
        j = 0
        for line in file:
            line = line.strip()
            instr = convertToMachineCode(line, j)
            write_string_to_file(output_file, instr)
            j += 1

#serves as main
def read(): 
    with open(assemblyWithoutPseudo, "r") as file:
        i = 0
        for line in file:
            line = line.strip()
            if (":" in line):
                splitVers = re.split(": ", line)
                key = splitVers[0]
                if (key in label_dict):
                    raise Exception("Duplicate label at line " + str(i) + ": '" + key + "'")
                else:
                    label_dict[key] = i
                    write_string_to_file(assemblyNoTag, splitVers[1])
            else:
                write_string_to_file(assemblyNoTag, line)        
            i += 1
    convert()

def replacePseudo():
    with open(pseudoNoLabel, "r") as source:
        source_lines = source.readlines()

    with open(pseudoInstructionFile, "r") as replacement:
        replacement_lines = replacement.readlines()

    replacement_map = {}
    current_key = None
    replacement_block = []  
    placeholder_values = {}

    for line in replacement_lines:
        line = line.strip()
        if line.endswith(":"):
            if current_key:
                replacement_block = [block for block in replacement_block if block.strip()]  
                replacement_map[current_key] = replacement_block  
                replacement_block = []  
            current_key = line.split(" ", 1)[0]  
            placeholder_values[current_key] = None  
        else:
            if current_key:
                replacement_block.append(line)

    if current_key:  
        replacement_block = [block for block in replacement_block if block.strip()]  
        replacement_map[current_key] = replacement_block


    print("Replacement Map:")
    for key, value in replacement_map.items():
        print(key, ":", value)

    
    with open(assemblyWithoutPseudo, "w") as output:
        b = 0 
        for line in source_lines:
            line = line.strip()  
            key, values = line.split(" ", 1)
            values = values.split(", ")
            if b in first_dict:
                print(first_dict[b])
                output.write(first_dict[b] + ": ")
            if key in placeholder_values:
                placeholder_values[key] = values  
                replacement_block = replacement_map.get(key, [])  
                replacements = replacement_block
                for i, value in enumerate(placeholder_values[key]):
                    replacements = [rep.replace(f"val{i + 1}", value) for rep in replacements]
                if replacements: 
                    output.write('\n'.join(replacements).strip() + '\n') 
                else:
                    output.write(line + '\n')  
            else:
                output.write(line + '\n')  
            print(b)
            b += 1
    print("Replacement completed. Output saved to", assemblyWithoutPseudo)
    read()

def removeTags():
    with open(input_file, "r") as source:
        k=0
        for line in source:
            line = line.strip()
            if (":" in line):
                    splitVers = re.split(": ", line)
                    key = splitVers[0]
                    if (key in first_dict):
                        raise Exception("Duplicate label at line " + str(k) + ": '" + key + "'")
                    else:
                        first_dict[k] = key
                        write_string_to_file(pseudoNoLabel, splitVers[1])
            else:
                    write_string_to_file(pseudoNoLabel, line)        
            k += 1
    for key in first_dict:
        print(key, ":", first_dict[key])
    replacePseudo()


def main():
    with open(output_file, 'w') as file:
        pass 
    with open(assemblyNoTag, 'w') as file:
        pass
    with open(pseudoNoLabel, 'w') as file:
        pass
    with open(assemblyWithoutPseudo, 'w') as file:
        pass
    removeTags()

main()