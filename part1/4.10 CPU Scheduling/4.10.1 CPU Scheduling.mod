/*********************************************
 * OPL 22.1.0.0 Model
 * Author: fayss
 * Creation Date: 26 Feb 2023 at 20:59:58
 *********************************************/
// inputs
 int nbCPUs = 3;
 range CPU = 1..nbCPUs;
 
 int nbProcesses = 7;
 range P = 1..nbProcesses;
 float processInstructions[P] = [1.1, 2.1, 3, 1, 0.7, 5, 3];
 
 float cpuSpeeds[CPU] = [1.33, 2, 2.66];
 
 // decision variables
 // which processor is doing which process instruction
 dvar int processingList[CPU][P];
 
 // objective function
 // we want to MINIMIZE the total time spent doing instructions
 // the time spent by a processor doing an instruction is ceil(processInstructions/cpuSpeed) 
 // the time to do all instructions is the maximum of processing time of all cpus
 minimize sum(p in P, cpu in CPU) ( processingList[cpu][p] * processInstructions[p] / cpuSpeeds[cpu] );
 
 subject to {
   
 }
 