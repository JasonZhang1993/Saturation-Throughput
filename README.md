# Saturation-Throughput
Model using ns-3 simulator on Linux to simulate IEEE 802.11 CSMA/CA technic. It uses a mechanism called DCF (distributed coordinated function) which applies a binary exponential backoff to avoid collisions.

This model simulate from physical layer, through mac layer to application layer to simulate the work from Bianchi in 1998. The Bianchi's model can be viewed as followed:

https://pdfs.semanticscholar.org/4a5c/f874e9469815113c7ea93ff97317bdb52a90.pdf

Authors: Jiayi Zhang, Qi Lyu

1. MATLAB Simulation Codes: project_simulation.m

	The Simulation codes to simulate Bianchi’s model.

	Operating System: tested on Mac. Should be able to run on Windows
	Required Software: Matlab

	Description of files

	1) Required inputs: minimum back off window size, and maximum stage. The two variables are defined by Bianchi: for example, W = 32, m = 3.

	2) The simulation will output the plot of saturation throughput versus number of stations.

2. MATLAB Computation Codes: project_computation.m

	Generate formula analysis to compute the results of Bianchi’s model.

	Operating System: tested on Mac. Should be able to run on Windows
	Required Software: Matlab

	Description of files

	1) Required inputs: minimum back off window size, and maximum stage. The two variables are defined by Bianchi: for example, W = 32, m = 3.

	2) The simulation will output the plot of saturation throughput versus number of stations by computation of formulas.

3. ns-3 Simulation Codes: project1.cc
	
	ns-3 simulation codes.
	
	Operating System: Ubuntu

	/******** IMPORTANT: Pre-set ********/

	Overwrite the source file “wifi-mac.cc”, “regular-wifi-mac.cc”, “dca-txop.cc”, and “dca-txop.h” in ns-3.26/src/wifi/model/ with the files provided in the folder “edited src files”, then type ./waf to build ns-3 environment. After successful build, project1.cc should be runnable.

	Description of files

	1) optional input:

	• nSta: number of station, default to be 5. For example, type in ./waf —-run “scratch/project1 —-nSta=50”

	• cxmin: the minimum contention window, it is the initial backoff window size by Bianchi minus 1. Default to be 31. For example, type in ./waf —-run “scratch/project1 —-cwmin=127”

	• cxmax: the maximum contention window, it is computed by 2^m*W-1 by Bianchi. Default to be 255 (W = 32, m = 3). For example, type in ./waf —-run “scratch/project1 —-cwmax=1023”

	• trace: bool variable to enable/disable simulator schedule. If enabled, user can supervise the aggregate throughput of the access point for each 0.1 second. Default to be false. For example, type in ./waf —-run “scratch/project1 —-trace=true”

	2) The simulation will output: a. the time first packet received by ap, b. the time last packet received by ap, c. the average actual throughput into ap.

	3) If trace is enabled, terminal will output simultaneous throughput each 0.1 second in the simulation.

	
	

	
