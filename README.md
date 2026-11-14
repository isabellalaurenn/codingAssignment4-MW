# Coding Assignment 4 -  Memory and Writeback
<!--
Replace every item in square brackets before submitting.
Keep this README focused on what the design does, how it is used, and how it was
verified.
-->
## Design Scope and Assumptions
- **In scope:** The Memory and Writeback (MEM/WB) stages of the MIPS pipeline are implemented. The memory state ANds the Branch control bit with the ALU Zero flag to produce PCSrc for the fetch stage, reads or writes the data memory, and stores the results in the MEM/WB latch. The write-back stage uses a mux to choose the value that is written back to the register file.
- **Out of scope:** Connecting all five stages into one complete pipeline, and hazard handling such as forwarding and stalls.
- **Assumptions:** 32-bit data and addresses. The data mem has 256 words, and the address from the ALU is used directly as the word index, so address 4 would refer to word 4. The data memory writes on the rising clock edge and reads combinationally. The MEM/WB latch captures on the rising clock edge. The memory control bits come in as separate branch, memread, and memwrite signals from the EX/MEM latch. Every word starts out equal to its index (0-255), and data.txt then loads words 0-5. The testbench clock has a 10 ns period.
- **Limitations:** Addresses of 256 or more are out of range, so reads return unknown and writes are ignored. Only whole 32-bit words can be accessed, with no byte or halfword access.

## Requirements
| Requirement | Description | Verification Method |
|---|---|---|
| REQ-01 | [The design shall ...] | [Test case, waveform, calculation, or
inspection] |
| REQ-02 | [The design shall ...] | [Test case, waveform, calculation, or
inspection] |
| REQ-03 | [The design shall ...] | [Test case, waveform, calculation, or
inspection] |

## Architecture
### Timing or Behavioral Summary
![Timing Diagram](images/timingDiagram.webp)

## Implementation
### Source Code
| File | Description |
|---|---|
| [`AND.v`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/AND.v) | ANDs Branch and Zero to product PCSrc |
| [`data_memory.v`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/data_memory.v) | 256-word data memory. Stores on the clock edge and reads combinationally |
| [`memory.v`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/memory.v) | Connects the AND gate, data memory, and MEM/WB Latch |
| [`memory_tb.v`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/memory_tb.v) | Testbench for the full memory stage |
| [`mem_wb_latch.v`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/mem_wb_latch.v) | Pipeline latch, clocked on the rising edge |
| [`writeback.v`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/writeback.v) | Writeback stage. Mux that selects the data written back to the register file |
| [`data.txt`](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/data.txt) | Initial contents of data memory words 0-5 |

### Implementation Notes
- [Explain one important design decision.]
- [Identify any parameterization, reusable module, or interface convention.]
- [Document any deliberate simplification made for this lab.]
  
## Verification
### Verification Strategy
The design is verified using **[simulation, formal checks, hardware testing, or
another method]**.
Verification covers:
- [Normal operating case]
- [Boundary or maximum-value case]
- [Reset or initialization case]
- [Invalid, stalled, or exceptional case, if applicable]
### Testbench and Waveform
Save screenshots and waveform images in the repository's `images/` folder.
![Testbench or waveform](images/[testbench-screenshot-filename].png)
The testbench source is available [*here*](https://github.com/isabellalaurenn/codingAssignment4-MW/blob/main/memory_tb.v).
### Results
| Test Case | Expected Result | Observed Result | Status |
|---|---|---|---|
| TC-01 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |
| TC-02 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |
| TC-03 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |

## Reproduction Instructions
### Tools and Versions
- **Simulator / synthesis tool:** Xilinx Vivado
- **Language / standard:** Verilog
- **Operating system:** Windows
- **Additional dependencies:** n/a
### Build and Run
```bash
# Replace these commands with the commands required for this lab.
[compile-command]
[run-command]
```
Expected output:
```text
[Paste a short representative output or result here.]
```

## Repository Organization
```text
.
├── README.md
├── images/
│ ├── [timing-diagram-filename].png
│ └── [testbench-screenshot-filename].png
├── [source-files]
└── [testbench-files]
```
## Known Issues and Future Improvements
- [Document any known issue, unverified behavior, or technical debt.]
- [Describe a realisti
