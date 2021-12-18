# OpenOFDM SDR Integration [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![ci workflow](https://github.com/andreaskuster/openofdm/actions/workflows/ci.yml/badge.svg)

This work extends the [OpenOFDM](https://github.com/jhshi/openofdm) repo from Jinghao Shi,

```
This project contains a Verilog implementation of 802.11 OFDM PHY decoder.
Features are:

 - Fully synthesizable (tested on Ettus Research USRP N210 platform)
 - Full support for legacy 802.11a/g
 - Support 802.11n for MCS 0 - 7 @ 20 MHz bandwidth
 - Cross validation with included Python decoder 
 - Modular design for easy modification and extension

See full documentation at http://openofdm.readthedocs.io.
```

with additional functionality:

- ci pipeline for cross-validation of the design
- upgrade from python2 to python3
- seamless Makefile integration into the [UHD](https://github.com/EttusResearch/uhd/) FPGA design for the Ettus Research
  B210 device (more devices will follow)
- bug-fixing and repo cleanup

Prequisites
=====

- python 3
- python3-virtualenv virtual environment module
- Icarus Verilog simulation and synthesis tool
- GTKWave VCD wave viewer

Setup
=====

Sourcing the script `setup_env.sh` will setup the required packages as well as a fresh python virtual environment with
all the modules required to validate the OpenOFDM verilog implementation against the software model:

```bash
source setup_env.sh
```

Running
=====

The cross-validation of the verilog design can be run using any I/Q sample input. Example usage:

```bash
python3 scripts/test.py testing_inputs/samples.dat
```

Integration
=====

Input and Output
-----
In a nutshell, the top level ``dot11`` Verilog module takes 32-bit I/Q samples (16-bit each) as input, and output
decoded bytes in 802.11 packet. The sampling rate is 20 MSPS and the clock rate is 100 MHz. This means this module
expects one pair of I/Q sample every 5 clock ticks.

Library Placement
-----
The library itself needs to be placed in the `fpga/usrp3/lib/` folder within the [Ettus Research UHD](https://github.com/EttusResearch/uhd/) repo. The dot11 module instantiation can be found in [integration/DEVICE_NAME](integration)

Makefile
-----
TODO

Dot11 Module Instantiation
-----
TODO


Device Compatibility
=====

| Device | FPGA Family |
| --- | --- |
| N200 | Spartan3A-DSP (untested) |
| N210 | Spartan3A-DSP (untested) |
| B200 | Spartan-6 (untested) |
| B200mini | Spartan-6 (untested) |
| B205mini | Spartan-6 (untested) |
| B210 | Spartan-6, tested |
| N310 | device incompatible with most WiFi standards, due to the sampling rate (master clock is no exact multiple of 20MHz) |
| X310 | porting in progress |
