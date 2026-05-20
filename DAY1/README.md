# Day 1: Introduction to Verilog RTL Design and Synthesis

## Contents
- [Understanding Simulator, Design, and Testbench](#1-Understanding-Simulator-Design-and-Testbench)
- [How to work with iverilog and GTK wave](#2-How-to-work-with-iverilog-and-GTK-wave)
- Practical: Simulating a 2:1 Multiplexer (good MUX) 
- Understanding the Verilog Code  
- Overview of Yosys and Standard Cell Libraries  
- Practical Synthesis Flow using Yosys  
- Key Takeaways  

---

## 1. Understanding Simulator, Design, and Testbench

**What is a Simulator?**
* A simulator is a software application used to verify the behavior of digital circuits.
  
**How Simulator Works?**
* It executes the design using different input   combinations and displays output responses, allowing engineers to validate functionality before implementation on hardware.
  

**What is a Design?**
* The design refers to the Verilog HDL description that defines the logic and operation of a digital circuit.

**What is a Test-Bench?**
* A testbench is a verification module used to stimulate the design with various test cases and monitor whether the generated outputs match expected behavior. The DUT is placed in the testbench. The testbench generates the stimuli (input signals) for the design and captures the output of the design, which is then compared with the expected output to verify the functionality of the design and checks the functionality.



Together, the design and testbench create a complete simulation environment for functional verification.

  <img width="787" height="385" alt="image" src="https://github.com/user-attachments/assets/190945a7-b139-4c1b-97b0-2d38cdc7af91" />

**iverilog Simulator Flow:**
* Give the design verilog code and testbench to iverilog.
* Any simulator looks for changes in input and dump changes in output
* Simulator (`iverilog`) takes design and testbench code and generates an output executable file called `a.out` (which has the changes in the output for the changes in the input).
* All the outputs of the simulator is Value Change Dump (VCD) format file.
* For observing the waveform we will give the `a.out` format file to GTKwave and observe the logic level changes.

  <img width="898" height="497" alt="image" src="https://github.com/user-attachments/assets/ba6a06b4-4b21-4875-bf5b-22c92168048d" />

## 2. How to work with iverilog and GTK wave

