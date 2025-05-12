# AXI integration of LFSR and connecting it to a Histogram binner using AXI stream


## Q1 and Q2

The modules given here are the testbenches and outputs that I have generated for this.

Note : In the top_tb.ram I have monitored the bins in axl_hist, not the axl_ram.



## Q3

## What did I learn in 2nd assignment's lecture and tutorials

## Wishbone protocol

We learnt about master slave archetecture. And how multiple IPs are connected to each other via common read and write bus. These modules require a common protocol for various reasons

a) Without a common interface, connecting chips and transferring data among each other is a big headache
b) Common bus cannot be implemented without common interface
c) IPs can be safeguarded by hiding all internal functionalities and only revealing the bus terminals. It is hard to deduce this way how it is operating.


About wishbone archetecture:

a) There are common signals like clk and reset
b) Data_in bus of master goes to data_out of slave and vice versa
c) If there are more bits being transferred, more SEL control signal is used
d) Strob is a signal that indicates data that has been transferred is valid
e) There was an option for user defined signals

But the control in wishbone archetecture was limited. 

So AXI interface was created:

Features:
a) All the input terminals are given a write address and their respective registers. So a write address and a write signal must be given to the module to give a single input. Likewise, all the inputs must be respectively given inputs after each clock cycle.

b) Similarly all output terminals are given read address and their respective registers. Data is stored in the register and retrieved accordingly.

c) An extra bus is involved telling to sender that write (or read(optional)) was successsful. (B bus) This is absent in AXI Stream and optional, but important, because if the write wasn't successful, the chip must tell the sender that it didn't recieve the correct data.

d) Each channel has a ready signal and a valid signal. Valid signal is given by the sender when the data is valid, and the ready signal is given by the reciever, when the reciever is able to recieve the signal.

e) Handshake: When all ready signal and valid signal are active, only then the data must be transmitted. That is a fundamental rule of this interface, and this is called a handshake.


There are 3 types of AXI interfaces

**note**:- Burst transfers are transfers where all registers are given data at once

a) AXI-STREAM : The simplest AXI interface that is built only for burst transfers and single master-slave interface. It has only 34 compulsory terminals - tvalid, tdata, and tready. This can be used only unidirectionally, meaning there can't be input data to the master. Feedbacks to the sent data are optional.

b) AXI- LITE : This cannot be used for burst transfer. It has 5 channels. 2 are to send read address and read data. 2 are for sending write address and write data. 1 is for sending write response(b channel, it sends data of whether the write was successful or not). Each channel has 3 buses, one for valid, one for ready, and one for data.

c) AXI : This is the interface with the most terminals and most control. It is complex but gives best control. The best two functionalities found here and usually not in other interfaces is the existence of strob and keep signals. strob signal tells which part of the 32 or 64 bit data is valid and useful. keep tells whether to actually use data, or just to read and ignore the data. Keep is useful when some process takes multiple clock cycles and hence the inital data from the first clock cycles shouldn't be transferred. 

# Multicore Processing

Multicore processing was one of the revolutions that led to increase in speeds of the CPU as we see today.

We learnt about 2 types of memory archetectures, shared and distributed. Distributed memory archetecture (NUMA) has memory distributed for each CPU. Accessing data from other memory sources takes more time, so there is non-uniform memory access (NUMA). 

We use a mix of both the archetectures. The L1 Cache and L2 cache are core specific and L3 is shared by all cores. 

There are some complexities involved in doing this
a) Atomic operations : Some operations cannot be divided and shared among different cpus. Because them executing the code parallely won't give the same output, compared to if run on a single core. So 1 core must take up the entire work.

b) Locks: When a shared lock is applied to a memory, then all the cores can read that memory, but no one can write. When an exclusive lock is applied, then only the core that applied exclusive lock can read or write. No other cores can access that memory. This is to prevent other cores reading the data before the write is enforced. But reads can happen paralelly

**dirty bit** :- a variable whose value has been changed in another core's memory but not this core's memory

# CHI protocol

CHI protocol is an optimised method for CPUs to communicate with each other. 

The major feature here is snoop.

Copies of data are stored in respective caches of each memory. One chip called snoop filter records whenever a read or write has been done to a signal. If a write signal is performed, it informs other cores to change their respective datas to the updated written data. 
