# Day 5 – RTL Optimization and Synthesis Concepts

This experiment explores how Verilog coding style impacts synthesized hardware using SKY130 standard cells.

## Topics Covered
- IF statements
- CASE statements
- Latch inference
- Partial assignments
- FOR vs GENERATE
- RTL Simulation
- Yosys Synthesis
- Gate-Level Simulation
- Ripple Carry Adder

---

# 1. IF Construct

IF statements execute sequentially and create priority logic.

### Example

```verilog
always @(*) begin
    if(cond1)
        y=a;
    else if(cond2)
        y=b;
    else
        y=c;
end
```

### Observations
- Priority-based evaluation
- Synthesizes into multiplexers
- Missing conditions may infer latches

---

# 2. Incomplete IF

```verilog
always @(*) begin
    if(enable)
        out=data;
end
```
<img width="1600" height="488" alt="image" src="https://github.com/user-attachments/assets/f67f5d78-86cb-414d-ad98-6915054095ad" />



<img width="586" height="285" alt="image" src="https://github.com/user-attachments/assets/c829e70a-ebe4-4093-8de4-03e6c75221e9" />

### Result
- No assignment for all cases
- Previous value retained
- Latch generated

---

# 3. CASE Statement

CASE is commonly used for selection logic.

```verilog
always @(*) begin
case(sel)

2'b00:y=i0;
2'b01:y=i1;
2'b10:y=i2;
default:y=i3;

endcase
end
```

### Uses
- Multiplexers
- Decoders
- Control circuits

---

# 4. Incomplete CASE

```verilog
case(sel)

2'b00:y=a;
2'b01:y=b;

endcase
```
<img width="1600" height="536" alt="image" src="https://github.com/user-attachments/assets/d680f79e-686b-4ce0-9384-1d2fc209bd72" />


<img width="1585" height="308" alt="image" src="https://github.com/user-attachments/assets/a7c9fc1d-d54b-4864-933a-b017223d3103" />
Synthesized netlist
### Result
- Uncovered states retain previous output
- Latch inferred

---
---

#  Complete CASE Statement

A complete CASE statement removes latch inference.

<img width="1525" height="553" alt="image" src="https://github.com/user-attachments/assets/bfd6a5e1-68c5-4b70-873a-45c7b9149253" /> 

<img width="1577" height="356" alt="image" src="https://github.com/user-attachments/assets/50c342c6-5495-4982-93f6-fe2911cb24de" />
Synthesized netlist


---
# 5. Partial Assignment

```verilog
case(sel)

2'b00:
begin
a=x;
b=y;
end

2'b01:
a=z;

endcase
```

### Result
- Some signals remain unassigned
- Creates memory behavior
- Synthesis infers latches

  Synthesized netlist
<img width="1589" height="483" alt="image" src="https://github.com/user-attachments/assets/64836751-6ed6-47ee-bb5c-6016602748d9" />

---

# 6. Overlapping Conditions

Improper CASE design can cause:

- Ambiguous outputs
- RTL vs hardware mismatch
- Unpredictable behavior

  Synthesized netlist
<img width="1582" height="808" alt="image" src="https://github.com/user-attachments/assets/9e84ce9f-9482-4626-8d55-02d74c6fce49" />

---

# 7. FOR vs GENERATE

| FOR | GENERATE |
|------|-----------|
| Behavioral | Structural |
| Inside always | Outside always |
| Logic evaluation | Hardware replication |

### FOR

```verilog
always @(*) begin

for(i=0;i<8;i=i+1)
begin
temp[i]=a[i]&b[i];
end

end
```

### GENERATE

```verilog
generate

for(i=0;i<8;i=i+1)
begin

and G1(out[i],a[i],b[i]);

end

endgenerate
```

### Key Difference
- FOR → behavior
- GENERATE → creates hardware

  # MUX using Generate

MUX implemented using iterative FOR logic.
---

<img width="1259" height="958" alt="image" src="https://github.com/user-attachments/assets/a6557829-a5d9-4f36-9204-1d19ed36a987" />

---
Synthesized netlist

<img width="1344" height="857" alt="image" src="https://github.com/user-attachments/assets/4e839c31-e230-45d1-8a76-f29c305104c9" />

---


# 8. RTL Simulation Flow

Compile:

```bash
iverilog design.v tb.v
```

Run:

```bash
./a.out
```

View waveform:

```bash
gtkwave dump.vcd
```

Purpose:
- Verify functionality
- Debug logic

---

# 9. Yosys Synthesis Flow

Start:

```tcl
yosys
```

Read library:

```tcl
read_liberty -lib sky130.lib
```

Read RTL:

```tcl
read_verilog design.v
```

Synthesize:

```tcl
synth -top design
```

Technology map:

```tcl
abc -liberty sky130.lib
```

Write netlist:

```tcl
write_verilog netlist.v
```

---

# 10. Gate Level Simulation

Compile:

```bash
iverilog \
primitives.v \
sky130.v \
netlist.v \
tb.v
```

Run:

```bash
./a.out
```

Purpose:
- Verify synthesized hardware
- Detect mismatches

---

# RTL vs GLS

| RTL | GLS |
|------|------|
| Behavioral | Gate-Level |
| Faster | Realistic |
| RTL code | Netlist |

---

# 11. Ripple Carry Adder using Generate

### Ripple Carry Adder using Generate

An **8-bit Ripple Carry Adder (RCA)** was implemented using **Full Adder modules** and a **generate block**. Each stage passes its carry output to the next stage, forming a carry chain.

**Full Adder:**

```verilog
module fa(input a,input b,input c,output co,output sum);
assign {co,sum}=a+b+c;
endmodule
```

**RCA using Generate:**

```verilog
generate
for(i=1;i<8;i=i+1)
begin
fa u_fa(.a(num1[i]), .b(num2[i]),
.c(int_co[i-1]),
.co(int_co[i]),
.sum(int_sum[i]));
end
endgenerate
```

### Key Point
- `for` → behavioral iteration
- `generate` → hardware replication

Compile and simulate:

```bash
iverilog fa.v rca.v tb_rca.v
./a.out
gtkwave tb_rca.vcd
```
<img width="1600" height="528" alt="image" src="https://github.com/user-attachments/assets/c7c2d0a3-8948-4713-aa38-f5cc6274341d" />


---

# Key Learnings

- Incomplete IF infers latch
- Incomplete CASE creates memory
- Complete assignments avoid latches
- FOR is behavioral
- GENERATE replicates hardware
- GLS validates synthesis
- SKY130 maps RTL into standard cells

---

# Conclusion

Day 5 demonstrated synthesis-aware RTL design, latch behavior, generate constructs, and verification flow using SKY130 technology.
