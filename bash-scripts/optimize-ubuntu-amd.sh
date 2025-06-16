#!/bin/bash

echo "=== Ubuntu Cleanup and AMD Optimization ==="

# Stop on error
set -e

# 1. Update & Clean
echo "[1/4] Updating system and removing cruft..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean

# 2. Enable performance mode
echo "[2/4] Setting CPU governor to 'performance'..."
for CPUFREQ in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo performance | sudo tee $CPUFREQ
done

# 3. AMD GPU Setup
echo "[3/4] Installing AMD GPU Drivers..."

# Add the latest oibaf PPA for Mesa (Open source drivers)
sudo add-apt-repository ppa:oibaf/graphics-drivers -y
sudo apt update
sudo apt upgrade -y  # Pull in new Mesa stack

# Optional: ROCm (for compute / ML)
# echo "Installing ROCm for compute workloads..."
# wget -qO - http://repo.radeon.com/rocm/rocm.gpg.key | sudo apt-key add -
# echo 'deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ ubuntu main' | sudo tee /etc/apt/sources.list.d/rocm.list
# sudo apt update
# sudo apt install rocm-dkms -y

# 4. Install additional performance tools
echo "[4/4] Installing performance tools (tlp, preload, etc.)..."
sudo apt install -y tlp preload zram-tools

# Start TLP
sudo systemctl enable tlp
sudo systemctl start tlp

echo "=== Done! Reboot recommended. ==="

