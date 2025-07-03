# Custom-Sequence-Detector


A basic parameterized sequence detector implemented using Verilog.

## Overview
This module detects any n-bit binary sequence from a serial data stream.  
The sequence and its length can be easily changed using parameters.

## Files
- `seq_det.v`: Verilog module for the sequence detector  
- `testbench.v`: Testbench to simulate and verify the design

## Usage
Update the parameters `n` and `sequence` to match the pattern you want to detect.  
The output goes high for one clock cycle when the full sequence is detected.

