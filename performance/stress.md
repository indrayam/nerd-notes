# Stress Testing Tool

## Useful Commands

These are commands from Amazon Linux 2023

```bash
sudo dnf install stress
## Generate CPU stress: 
stress --cpu <number-of-threads>
## Generate memory stress: 
stress --vm <number-of-threads> --vm-bytes <memory-size>
##Generate I/O stress: 
stress --io <number-of-threads>
## Generate disk stress: 
stress --hdd <number-of-threads>
```