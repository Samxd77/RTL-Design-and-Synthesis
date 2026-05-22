# Day 1: Introduction to Verilog RTL Design and Synthesis

## Contents
- [Understanding Simulator, Design, and Testbench](#1-Understanding-Simulator-Design-and-Testbench)
- [How to work with iverilog and GTK wave](#2-How-to-work-with-iverilog-and-GTK-wave)
- [Practical: Simulating a 2:1 Multiplexer (good MUX)](#3-practical-simulating-a-21-multiplexer-good-mux)
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
* A testbench is a verification module used to stimulate the design with various test cases and monitor whether the generated outputs match expected behavior. The DUT is placed in the testbench. T[...]



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

### Installation

**For Ubuntu/Debian Linux:**
```bash
sudo apt-get update
sudo apt-get install iverilog gtkwave
```

**For macOS:**
```bash
brew install icarus-verilog gtkwave
```

**For Windows:**
* Download and install from [Icarus Verilog official website](http://iverilog.icarus.com/)
* Download and install GTKwave from [GTKwave official website](http://gtkwave.sourceforge.net/)

### Basic Workflow

#### Step 1: Prepare Your Design and Testbench Files

Create two Verilog files:
- **Design file** (e.g., `mux_2to1.v`) - Contains the actual circuit logic
- **Testbench file** (e.g., `mux_2to1_tb.v`) - Contains test cases and stimulus

Example structure:
```
project/
├── mux_2to1.v          (Design)
├── mux_2to1_tb.v       (Testbench)
└── simulation/         (Output directory)
```

#### Step 2: Compile with iverilog

Run the following command to compile your design and testbench:

```bash
iverilog -o a.out mux_2to1.v mux_2to1_tb.v
```

**Command breakdown:**
- `iverilog` - Invokes the Icarus Verilog compiler
- `-o a.out` - Specifies the output executable filename
- `mux_2to1.v mux_2to1_tb.v` - Input Verilog files (design first, then testbench)

**What happens:**
- iverilog checks for syntax errors
- If successful, generates an executable file `a.out`
- If errors occur, they are displayed in the terminal

#### Step 3: Execute the Simulation

Run the compiled executable to generate the VCD file:

```bash
./a.out
```

**What happens:**
- The testbench executes the simulation
- All signal changes are captured
- A VCD file is generated (typically named `dump.vcd` by default, or as specified in testbench)

#### Step 4: View Waveforms with GTKwave

Open the generated VCD file with GTKwave:

```bash
gtkwave dump.vcd &
```

**The `&` at the end runs GTKwave in the background, allowing you to continue using the terminal.**

### Understanding the GTKwave Interface

**Left Panel - Hierarchy View:**
- Shows the module hierarchy of your design
- Lists all signals and variables in each module
- Expand modules to see their internal signals

**Middle Panel - Signal Selection:**
- Displays all available signals from the selected module
- Double-click signals to add them to the waveform view
- Use Ctrl+Click for multiple selections

**Right Panel - Waveform View:**
- Displays the timing diagram of selected signals
- Shows logic level changes (0, 1, X, Z)
- Use scroll bar to navigate through time
- Zoom in/out to see details or overview

### Useful GTKwave Features

**Navigation:**
- **Zoom In:** Scroll wheel up or use View → Zoom In
- **Zoom Out:** Scroll wheel down or use View → Zoom Out
- **Fit to Window:** View → Zoom → Fit to Window
- **Pan:** Click and drag in the waveform area

**Signal Analysis:**
- **Search Signals:** Use Edit → Search to find specific signals
- **Mark Time:** Click on waveform to set markers for timing analysis
- **Measure Delay:** Use markers to measure time differences between events
- **Change Radix:** Right-click signal → Format to display in Binary, Hex, Decimal, etc.

**Customization:**
- **Rename Signals:** Right-click → Rename for clarity
- **Group Signals:** Use Edit → Insert Group to organize related signals
- **Color Signals:** Right-click → Color to highlight important signals

### Complete Workflow Example

```bash
# Step 1: Compile design and testbench
iverilog -o a.out mux_2to1.v mux_2to1_tb.v

# Step 2: Run simulation (generates dump.vcd)
./a.out

# Step 3: View waveforms
gtkwave dump.vcd &
```



---

## 3. Practical: Simulating a 2:1 Multiplexer (good MUX)

### Simulation Setup

**Compile the design and testbench:**
```bash
iverilog -o a.out mux_2to1.v mux_2to1_tb.v
```

**Run the simulation:**
```bash
./a.out
```

This generates `dump.vcd` containing all signal transitions.

### Viewing Output in GTKwave

**Launch GTKwave:**
```bash
gtkwave dump.vcd &
```

**Observing the Results:**

<img width="992" height="633" alt="image" src="https://github.com/user-attachments/assets/1d9dde47-d5a1-4203-9b57-212290feccf6" />


1. **Expand the module hierarchy** - Click on `mux_2to1_tb` to view signals
2. **Select signals to observe:**
   - `i_0` - First input (0 or 1)
   - `i_1` - Second input (0 or 1)
   - `sel` - Select line (control signal)
   - `y` - Output (multiplexed result)

3. **Verify MUX behavior in the waveform:**
   - When `sel = 0`: `y` follows `i_0`
   - When `sel = 1`: `y` follows `i_1`

4. **Use GTKwave tools:**
   - **Zoom in** on specific transitions to see timing details
   - **Mark time** at signal changes to verify synchronization
   - **Change display format** (right-click) to Binary for clearer bit viewing

### Expected Output

The waveform should show the MUX correctly selecting between two inputs based on the select signal with zero propagation delay in an ideal simulation environment.

---

**Next:** Understanding the Verilog Code
