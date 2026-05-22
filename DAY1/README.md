# Day 1: Introduction to Verilog RTL Design and Synthesis

## Contents
- [Understanding Simulator, Design, and Testbench](#1-Understanding-Simulator-Design-and-Testbench)
- [How to work with iverilog and GTK wave](#2-How-to-work-with-iverilog-and-GTK-wave)
- [Practical: Simulating a 2:1 Multiplexer (good MUX)](#3-practical-simulating-a-21-multiplexer-good-mux)
- [Understanding the Verilog Code](#4-Understanding-the-Verilog-Code)
- [Introduction to Yosys and Logic Synthesis](#5-Introduction-to-Yosys-and-Logic-Synthesis)
- [Summary](#6-Summary)

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
  <img width="1304" height="681" alt="image" src="https://github.com/user-attachments/assets/5923c12d-9f53-43e3-8f41-aec195593790" />

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

## 4. Understanding the Verilog Code





<img width="548" height="495" alt="image" src="https://github.com/user-attachments/assets/927404b4-15ca-46c6-a005-570b0d681d26" />



<img width="704" height="203" alt="image" src="https://github.com/user-attachments/assets/523cb9c2-2c32-48b1-b47b-fd514c5feefd" />

###  **How It Works**

- **Inputs:** `i0`, `i1` (data), `sel` (select line)
- **Output:** `y` (registered output)
- **Logic:** If `sel` is 1, `y` gets `i1`; if `sel` is 0, `y` gets `i0`.

## 5. Introduction to Yosys and Logic Synthesis

**Yosys** is an open-source synthesis framework used in digital design. It transforms Verilog HDL into a gate-level representation that can later be implemented on FPGA or ASIC platforms.

#### Features of Yosys
- **Synthesis:** Converts HDL to a logic circuit
- **Optimization:** Improves speed or area
- **Technology Mapping:** Matches logic to actual hardware cells
- **Verification:** Checks correctness
- **Extensibility:** Supports custom flows

  ## Why Different Gate Variants Exist?



Synthesis tools automatically choose the most suitable cells based on design requirements.

<img width="866" height="493" alt="image" src="https://github.com/user-attachments/assets/0946c239-4954-42d9-9b30-d8ea98060120" />



<img width="867" height="485" alt="image" src="https://github.com/user-attachments/assets/74d72222-b648-40aa-8d7e-57333498c3da" />

   ### Logic Synthesis


# Synthesis Process

Synthesis converts **RTL (Verilog code)** into a **gate-level netlist** using library cells.

Flow:
RTL → Synthesis Tool → Netlist

- Converts HDL into logic gates
- Creates gate interconnections
- Produces a final netlist file
- Used for FPGA/ASIC implementation


 <img width="642" height="484" alt="image" src="https://github.com/user-attachments/assets/afae5b2e-fa67-45af-9873-fa1705fc817f" />


   A `.lib` file contains multiple versions of gates with different characteristics:

- **Speed:** Fast or slower implementations
- **Power:** Low-power alternatives
- **Area:** Compact cells for smaller layouts
- **Drive Strength:** Ability to handle larger loads
- **Signal Reliability:** Improved performance/noise handling

<img width="648" height="480" alt="image" src="https://github.com/user-attachments/assets/9ccb96dc-5220-4a95-98d5-c826c5b1ffe1" />

# Why Different Gate Flavours Exist?

Circuit speed depends on **combinational path delay**.

Clock relation:

Tclk > Tc-q + Tcomb + Tsetup

Key points:
- Smaller **Tcomb** → higher operating speed
- Faster cells reduce delay
- Libraries provide multiple gate variants
- Tool selects suitable cells based on timing, power and area constraints

<img width="647" height="483" alt="image" src="https://github.com/user-attachments/assets/d9090e6e-39e7-4db9-86cd-2198ef1e726c" />


`good_mux` design using Yosys!

###  Yosys Flow

**Start Yosys**
    ```shell
    yosys
    ```

**Read the liberty library**
    ```shell
    read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```

**Read the Verilog code**
    ```shell
    read_verilog good_mux.v
    ```

**Synthesize the design**
    ```shell
    synth -top good_mux
    ```

**Technology mapping**
    ```shell
    abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
    ```

**Visualize the gate-level netlist**
    ```shell
    show
    ```
<img width="607" height="331" alt="image" src="https://github.com/user-attachments/assets/93dabe71-4218-462f-b968-fcc1310d1f93" />


## 6. Summary

# Day 1 Summary

Day 1 covered the complete RTL-to-gate-level design flow using open-source VLSI tools.

## Topics Learned
- RTL design and testbench basics
- Simulation using Iverilog
- Waveform analysis with GTKWave
- Fundamentals of logic synthesis
- Standard cell library concepts
- Setup and hold timing
- Fast vs slow standard cells
- Synthesis using Yosys
- Technology mapping with Sky130 libraries
- Gate-level netlist generation
- Post-synthesis verification

This session built the foundation for understanding how Verilog RTL is transformed into real digital hardware.




