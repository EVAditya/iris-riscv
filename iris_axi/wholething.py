# Trying to simulate everything that was done in this program on python

# The best taps I found are [0, 0, 0, 1, 1, 1, 0, 1] (0x1D), [0,1,1,0,1,0,0,1] (0x2B), [0,1,1,0,0,1,0,1] (0x4D)

bin = [0 for i in range(8)]
def binner(num):
    if 1 <= num <= 32:
        bin[0]+=1
    elif 33 <= num <= 64:
        bin[1]+=1
    elif 65 <= num <= 96:
        bin[2]+=1
    elif 97 <= num <= 128:
        bin[3]+=1
    elif 129 <= num <= 160:
        bin[4]+=1
    elif 161 <= num <= 192:
        bin[5]+=1
    elif 193 <= num <= 224:
        bin[6]+=1
    elif num==255:
        bin[7]+=1

lfsr_numlist = []
start =1
stop = 256
seed = [0, 0, 1, 1, 1, 0, 1, 0]
taps = [0, 0, 0, 1, 1, 1, 0, 1] # 0x1D

# Don't change anything below
lfsr = seed.copy()


for i in range(start, stop):
    feedback = 0
    for j in range(len(taps)):
        feedback ^=( lfsr[j] & taps[j])
    lfsr.insert(0, feedback)
    lfsr.pop()
    lfsr_string = ''.join(str(x) for x in lfsr)
    lfsr_num= int(lfsr_string, 2)
    lfsr_numlist.append(lfsr_num)
    binner(lfsr_num)
    print(hex(lfsr_num), bin)



# Uncomment the below code to check for missing numbers


count = 0
for j in range(1,256):
    if j not in lfsr_numlist:
        print(f"Missing number: {j} ")
        count+=1
print(f"Total: {count}")