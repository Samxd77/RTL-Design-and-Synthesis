# Day 2: Library Analysis, Synthesis Styles and Sequential Design

## Session Objectives

This session explored timing libraries, synthesis strategies, flip-flop implementation, and optimization behavior during RTL synthesis.

---

## Understanding Timing Libraries

The `.lib` file contains information required by synthesis tools to make implementation decisions.

Key data available inside libraries:

- Timing and delay values
- Power information
- Process operating conditions
- Cell functionality
- Pin transition details
- Area and leakage values

### SKY130 PDK 

The SKY130 PDK is an open-source Process Design Kit based on SkyWater Technology's 130nm CMOS technology. It provides essential models and libraries for integrated circuit (IC) design, including timing, power, and process variation information.


### SKY130 Naming Convention

Example:

tt_025C_1v80

Meaning:

- `tt` → Typical process corner
- `025C` → Operating temperature: 25°C
- `1v80` → Supply voltage: 1.8V

These parameters define the environment for cell characterization.

---

<img width="835" height="637" alt="image" src="https://github.com/user-attachments/assets/b9b36762-8a91-491a-951e-65fca7324bf5" />


<img width="1267" height="710" alt="image" src="https://github.com/user-attachments/assets/5288bbe6-2d7c-4f28-ad95-2fb78890927e" />

## Cell Drive Strength Comparison

Standard cells are available in multiple variants.

Observed trends:

- Larger drive strength → increased transistor size
- Higher drive → larger area
- Power consumption increases
- Delay reduces with stronger cells

Trade-offs between area, timing and power decide cell selection.

---

## Synthesis Approaches

### Hierarchical Flow

The design hierarchy remains unchanged after synthesis.

Benefits:

- Better readability
- Easier debugging
- Faster processing for large designs

Limitation:

- Optimization across modules is restricted

---

<img width="609" height="254" alt="image" src="https://github.com/user-attachments/assets/ba2baea4-cbe1-433d-b438-699db49ccb4b" />

### Flat Synthesis

Hierarchy is removed and converted into one unified structure.

Benefits:

- Better logic optimization
- Improved design reduction opportunities

Limitations:

- Harder to trace modules
- Increased complexity

Command used:

```bash
flatten
```

---
<img width="790" height="118" alt="image" src="https://github.com/user-attachments/assets/39457d1c-0af5-4688-9620-bf9545fd23d3" />

### Key Differences

| Aspect                | Hierarchical Synthesis             | Flattened Synthesis           |
|-----------------------|------------------------------------|------------------------------|
| Hierarchy             | Preserved                          | Collapsed                    |
| Optimization Scope    | Module-level only                  | Whole-design                 |
| Runtime               | Faster for large designs           | Slower for large designs     |
| Debugging             | Easier (traces to RTL)             | Harder                       |



## Module-Level Synthesis

Specific modules can be synthesized separately.

```bash
synth -top module_name
```

Reasons:

- Reused blocks need synthesis only once
- Useful for divide-and-conquer design methodology
- Helps manage large-scale projects

---

## Why Flip-Flops are Needed

Long combinational chains create unstable outputs due to glitches. Flip-flops are fundamental sequential elements in digital design, used to store binary data. Below are efficient coding styles for different reset/set behaviors.


Flip-flops:

- Store stable values
- Capture data using clock edges
- Prevent glitch propagation
- Improve timing reliability

Control signals:

- Reset
- Set

These may be:

- Synchronous
- Asynchronous

---

## Flip-Flop Variants Studied

- DFF with asynchronous reset
- DFF with asynchronous set
- DFF with synchronous reset

  ### Synchronous Reset D Flip-Flop

```verilog
module dff_syncres (input clk, input async_reset, input sync_reset, input d, output reg q);
  always @ (posedge clk)
    if (sync_reset)
      q <= 1'b0;
    else
      q <= d;
endmodule
```
- **Synchronous reset**: Takes effect only on the clock edge.

  ### Asynchronous Set D Flip-Flop

```verilog
module dff_async_set (input clk, input async_set, input d, output reg q);
  always @ (posedge clk, posedge async_set)
    if (async_set)
      q <= 1'b1;
    else
      q <= d;
endmodule
```
- **Asynchronous set**: Overrides clock, setting q to 1 immediately.


Simulation performed using:

```bash
iverilog design.v testbench.v
./a.out
gtkwave waveform.vcd
```

---

## DFF Mapping During Synthesis

For sequential logic mapping:

```bash
dfflibmap -liberty library.lib
```

The synthesis tool maps RTL flip-flops to equivalent standard-cell versions.

In some cases, additional logic such as inverters may be inserted when reset polarities differ.

---

## Synthesis Optimization Examples

The synthesis engine can eliminate unnecessary hardware.

Examples:

- Bit shifting replaced with wire assignments
- Constant expressions simplified
- Redundant logic removed

Result:

- Reduced hardware utilization
- Faster implementation
- Lower area cost

---

## Summary

Day 2 introduced timing-aware synthesis concepts, hierarchy handling methods, sequential design implementation and automatic optimization techniques used in ASIC design flow.
