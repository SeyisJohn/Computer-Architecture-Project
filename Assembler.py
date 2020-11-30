# This is the assembler code for our Computer Architecture Project
# This program will check for a txt file that has instructions written in it
# This program will then create a txt file with the opcodes of all the instructions and their PC counter locations


# Load Immediate:                                             li (Load index) (16-bit immediate - in decimal) (rd)

# Multiply-Add and Multiply-Subtract R4-Instruction Format:   (instruction) (rs3) (rs2) (rs1) (rd)
# Signed Integer Multiply-Add Low with Saturation:            IAL (rs3) (rs2) (rs1) (rd)
# Signed Integer Multiply-Add High with Saturation:           IAH "                    "
# Signed Integer Multiply-Subtract Low with Saturation:       ISL "                    "
# Signed Integer Multiply-Subtract High with Saturation:      ISH "                    "
# Signed Long Integer Multiply-Add Low with Saturation:       LAL "                    " 
# Signed Long Integer Multiply-Add High with Saturation:      LAH "                    "
# Signed Long Integer Multiply-Subtract Low with Saturation:  LSL "                    "
# Signed Long Integer Multiply-Subtract High with Saturation: LSH "                    "

# R3-Instruction Format:
# (instruction) (rs2) (rs1) (rd)
# For example:
# -NOP 0 0 0

def main():
    f = open("Instruction.txt", "r")

    Opcode = []

    for line in f:
        temp = line.strip("\n")
        array = temp.split(" ")
        
        if(array[0] == "LI"):
            str1 = convertKeywordToBinary(array[0])
            str2 = f'{int(array[1]):03b}'
            str3 = f'{int(array[2]):016b}'
            str4 = convertRegNumToBinary(array[3])
            Opcode.append(str1+str2+str3+str4)
        
        elif (len(array) == 5): #If the array stores the R4 Instruction
            str1 = convertKeywordToBinary(array[0])
            str2 = convertRegNumToBinary(array[1])
            str3 = convertRegNumToBinary(array[2])
            str4 = convertRegNumToBinary(array[3])
            str5 = convertRegNumToBinary(array[4])
            Opcode.append(str1+str2+str3+str4+str5)

        elif (len(array) == 4): #If the array stores the R3 Instruction
            
            str1 = convertKeywordToBinary(array[0])
            str2 = convertRegNumToBinary(array[1])
            str3 = convertRegNumToBinary(array[2])
            str4 = convertRegNumToBinary(array[3])
            Opcode.append(str1+str2+str3+str4)
        
    count = 0
    fw = open("Opcode.txt", "a")

    for x in Opcode:
        fw.write(x + "\n")
        count += 1
        # print(x)

    fw.write("1111110000000000000000000") # Write a NOP instruction with some information to inform program to that it has reached the end
    

        


# This function will output bits of the opcode for specific instruction
# i.e AU will output 11xxxx0001
# li will output 0
# IAL will output 10000
def convertKeywordToBinary(word):
    
    if (word == "LI"):
        return "0"

    elif (word == "IAL"):
        return "10000"
    
    elif (word == "IAH"):
        return "10001"

    elif (word == "ISL"):
        return "10010"

    elif (word == "ISH"):
        return "10011"

    elif (word == "LAL"):
        return "10100"

    elif (word == "LAH"):
        return "10101"

    elif (word == "LSL"):
        return "10110"

    elif (word == "LSH"):
        return "10111"

    elif (word == "NOP"):
        return "1100000000"

    elif (word == "AU"):
        return "1100000001"

    elif (word == "ABSDB"):
        return "1100000010"

    elif (word == "AHU"):
        return "1100000011"

    elif (word == "AHS"):
        return "1100000100"

    elif (word == "AND"):
        return "1100000101"

    elif (word == "BCW"):
        return "1100000110"

    elif (word == "MAXWS"):
        return "1100000111"

    elif (word == "MINWS"):
        return "1100001000"

    elif (word == "MLHU"):
        return "1100001001"

    elif (word == "MLHCU"):
        return "1100001010"

    elif (word == "OR"):
        return "1100001011"

    elif (word == "PCNTW"):
        return "1100001100"

    elif (word == "ROTW"):
        return "1100001101"

    elif (word == "SFHS"):
        return "1100001110"

    elif (word == "SFW"):
        return "1100001111"

    else:
        print(word)
        print("Incorrect Syntax")


def convertRegNumToBinary(num):
    return f'{int(num):05b}'



if __name__ == '__main__':
    main()
