<h1 align="center">🔀 FSM Controlled AHB to APB Bridge</h1>

<p align="center">
A Verilog HDL based AMBA protocol bridge that connects the high-speed AHB bus with the low-speed APB bus using a Finite State Machine (FSM) controller.
</p>

---

## 📌 Overview

This project implements an FSM-controlled AHB to APB Bridge for AMBA-based System-on-Chip (SoC) architectures.

The bridge acts as an interface between:

- ⚡ Advanced High-performance Bus (AHB)
- 🔋 Advanced Peripheral Bus (APB)

The FSM controller manages protocol conversion, synchronization, and data transfer between the two buses efficiently.

The design supports both read and write operations while ensuring proper timing and reliable communication between high-speed processors and low-speed peripheral devices.

---

## ✨ Features

- 🔄 AHB to APB Protocol Conversion
- 🧠 FSM-Based Control Logic
- 📥 Read Operation Support
- 📤 Write Operation Support
- ⚡ Efficient Data Transfer
- 🖥️ Verilog HDL Implementation
- 📊 Simulation & Waveform Verification
- 🔋 Low-Power Peripheral Communication
- 🧩 Modular Design Architecture
- 🚀 AMBA Compliant Design

---

## 🛠️ Technologies Used

- Verilog HDL
- FSM Design
- AMBA AHB Protocol
- AMBA APB Protocol
- Digital System Design
- ModelSim
- Xilinx Vivado

---

## ⚙️ Working Principle

- AHB master initiates a transaction
- FSM detects the transfer type
- Address and control signals are decoded
- Bridge converts AHB transactions into APB-compatible signals
- APB peripheral performs read/write operation
- Data is transferred back to AHB master
- FSM controls setup, enable, and transfer phases
- Synchronization ensures reliable communication

---

## 🧠 FSM States

The FSM controller consists of multiple states:

- IDLE State
- READ State
- WRITE State
- SETUP State
- ENABLE State
- WAIT State

These states manage protocol timing and bus control operations.

---

## 📂 Project Modules

- AHB Slave Interface
- APB Controller
- FSM Controller
- Address Decoder
- Data Path Logic
- Top Module
- Testbench

---

## 🚀 How to Run

### Step 1 — Open Project

Open the project in:

- ModelSim
- Vivado
- Xilinx ISE

---

### Step 2 — Compile Verilog Files

Compile all Verilog source files and testbench files.

---

### Step 3 — Run Simulation

```bash
vsim ahb_to_apb_tb
run -all
```

---

## 📊 Simulation Outputs

- AHB Read Operation
- AHB Write Operation
- APB Transfer Signals
- FSM State Transitions
- Address Decoding Verification
- Timing Waveform Analysis

---

## 📈 Advantages

- Simple and Efficient Architecture
- Reduced Power Consumption
- Reliable Data Communication
- Supports Multiple Peripherals
- Easy Integration with SoC Designs
- Modular and Scalable Design

---

## 🏢 Applications

- System-on-Chip (SoC) Design
- ARM-Based Embedded Systems
- FPGA Prototyping
- ASIC Design
- Peripheral Communication Systems
- Low-Power Embedded Applications

---

## 🔮 Future Enhancements

- Multi-Master Support
- Pipelined Transfers
- Burst Transfer Support
- Error Handling Improvements
- Advanced Verification using UVM
- Low-Latency Optimization

---

## 📂 Project Structure

```text
FSM-Controlled-AHB-to-APB-Bridge/
│
├── apb_memory.v
├── project.v
├── project_tb.v
├── README.md
└── waveforms/
```

---

## 📸 Simulation Preview

Add simulation waveform screenshots or GIF here.

```md
![Waveform](waveform.png)
```

---

## 👨‍💻 Author

Developed using Verilog HDL for AMBA bus protocol conversion and FSM-based communication control.

---

## 📜 License

This project is open-source and intended for educational and learning purposes.
<img width="1478" height="615" alt="Image" src="https://github.com/user-attachments/assets/cee9085b-5739-43bb-bd47-d62c37eaf628" />
<img width="809" height="459" alt="Image" src="https://github.com/user-attachments/assets/9837251e-7707-4c41-ad64-7be6b070964e" />
<img width="767" height="528" alt="Image" src="https://github.com/user-attachments/assets/73bf80b6-c030-4b40-bf51-1b10967a17a9" />
<img width="688" height="828" alt="Image" src="https://github.com/user-attachments/assets/537698bd-1c88-4677-be8e-a8bd59a74f0a" />

<img width="1027" height="482" alt="Image" src="https://github.com/user-attachments/assets/a70a8333-fb35-43e2-8a95-f74ca8aefc4e" />
<img width="1363" height="808" alt="Image" src="https://github.com/user-attachments/assets/75b683b4-25c9-4198-a930-f43fcdd0fec9" />
<img width="1361" height="567" alt="Image" src="https://github.com/user-attachments/assets/188f5039-034d-47fd-a0c2-33c4a004e29c" />
<img width="710" height="810" alt="Image" src="https://github.com/user-attachments/assets/dfee0c42-8712-431d-88ec-41e10586a79b" />
<img width="540" height="775" alt="Image" src="https://github.com/user-attachments/assets/1a921ccd-6c20-469d-8841-6f2ae5205f20" />
<img width="716" height="581" alt="Image" src="https://github.com/user-attachments/assets/294cad55-52bb-4be8-bc23-f0f05ce475b2" />
<img width="545" height="776" alt="Image" src="https://github.com/user-attachments/assets/76fadb64-a6fe-4e90-996e-f191621e0bf4" />
<img width="1917" height="794" alt="Image" src="https://github.com/user-attachments/assets/efcced85-ef88-4dd8-9785-5318bbca6d64" />
