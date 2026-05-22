# RTL Design & Synthesis using SKY130 Workshop 
**Workshop Managed by** VSDIAT Community
**Created By:** Samarth Satwar  

---

# Project Overview

This repository contains hands-on work and concepts explored during the RTL Design and Synthesis workshop using open-source VLSI tools and the SKY130 PDK.

The workflow covers the complete path from **Verilog RTL → Simulation → Synthesis → Technology Mapping → Gate-Level Implementation**.

---

# Main Learning Outcomes

Throughout the workshop, the following concepts were explored:

- Verilog RTL design fundamentals
- Writing and understanding testbenches
- RTL simulation using **Icarus Verilog**
- Waveform inspection using **GTKWave**
- Logic synthesis through **Yosys**
- Technology mapping using **SKY130 libraries**
- Understanding timing libraries (`.lib`)
- Hierarchical and flattened synthesis methods
- Flip-flop coding techniques
- Gate-level netlist generation
- Timing and optimization concepts
- Post-synthesis analysis and verification

---

# Requirements

Recommended background:

- Digital electronics fundamentals
- Basic Verilog knowledge
- Familiarity with Linux terminal commands
- Ubuntu / WSL environment

Required tools:

- Git
- Icarus Verilog
- GTKWave
- Yosys
- SKY130 PDK
- Text editor (VS Code / gedit)
---

# 🧭 Complete RTL Design Flow

```text
Specification
      ↓
RTL Design (Verilog)
      ↓
RTL Simulation using Icarus Verilog
      ↓
Waveform Verification using GTKWave
      ↓
Logic Synthesis using Yosys
      ↓
Technology Mapping using SKY130
      ↓
Gate-Level Netlist Generation
      ↓
Gate-Level Simulation (GLS)
      ↓
Optimization & Verification
```

---

# Repository Structure

The repository is divided into daily modules:

### Day 1
Introduction to Verilog RTL Design and Synthesis

### Day 2
Library Analysis, Synthesis Styles and Sequential Design

### Day 3
Optimization of combinational and sequential logic

### Day 4
Gate-Level Simulation (GLS), Blocking vs. Non-Blocking in Verilog, and Synthesis-Simulation Mismatch

### Day 5
RTL Optimization and Synthesis Concepts

---

# Acknowledgement

Special thanks to the VSD community , Kunal Ghosh sir and open-source EDA ecosystem for making practical VLSI learning accessible.

Tools and resources used:

- SKY130 PDK
- Yosys
- Icarus Verilog
- GTKWave
