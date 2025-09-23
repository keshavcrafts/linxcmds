#!/bin/bash
# ======================================================
# Ubuntu Dev & Learning Setup Script
# Tested on Ubuntu 24.04.x
# ======================================================

set -e

echo ">>> Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y

echo ">>> Enabling universe/multiverse repos..."
sudo add-apt-repository universe -y
sudo add-apt-repository multiverse -y
sudo apt update

echo ">>> Installing essential build/dev tools..."
sudo apt install -y build-essential git curl wget unzip pkg-config \
  cmake gcc g++ make

echo ">>> Installing common utilities..."
sudo apt install -y vim nano htop tree net-tools

echo ">>> Installing VS Code (snap)..."
sudo snap install --classic code

echo ">>> Installing Python and pip tools..."
sudo apt install -y python3 python3-venv python3-pip
python3 -m pip install --user pipenv virtualenv

echo ">>> Installing Node.js (LTS)..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo ">>> Installing Docker..."
sudo apt install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER

echo ">>> Installing desktop extras..."
sudo apt install -y gnome-tweaks gnome-shell-extensions
sudo apt install -y ubuntu-restricted-extras vlc

echo ">>> Ensuring Snap & Flatpak..."
sudo apt install -y snapd flatpak

echo ">>> Installing SSH server..."
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo ufw allow OpenSSH

echo ">>> Setting up firewall..."
sudo apt install -y ufw
sudo ufw enable
sudo ufw status verbose

echo ">>> Installing VirtualBox Guest Additions..."
sudo apt install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

echo ">>> Installing useful GUI apps..."
sudo snap install postman --classic
sudo apt install -y gnome-disk-utility

echo ">>> Adding helpful aliases..."
echo "alias ll='ls -alF'" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc
source ~/.bashrc

echo "======================================================"
echo ">>> Setup completed. Please reboot your system."
echo "======================================================"
