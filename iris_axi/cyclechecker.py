# hexlist = []
# with  open("memory.text",'r') as lines:
#     for line in lines:
#         num=hex(int("0x"+line.strip(),16))
#         hexlist.append(num)


lfsr_numlist = []
start =1
stop = 256
seed = [0, 0, 0, 1, 1, 1, 0, 1]
taps = [0, 0, 0, 1, 1, 1, 0, 1] # 0x1D

lfsr = seed.copy()


for i in range(start, stop):
    feedback = 0
    for j in range(len(taps)):
        feedback ^=( lfsr[j] & taps[j])
    lfsr.insert(0, feedback)
    lfsr.pop()
    lfsr_string = ''.join(str(x) for x in lfsr)
    lfsr_num= int(lfsr_string, 2)
    lfsr_numlist.append(str(hex(lfsr_num)))


for game in lfsr_numlist:
    print(game)


# with open("memory.text",'r') as lines:
#     for ind,line in enumerate(lines):
#         print(lfsr_numlist[ind])
#         if("0x"+line == lfsr_numlist[ind]):
#             print(ind,line)



