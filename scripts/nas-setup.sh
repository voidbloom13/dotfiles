#!/bin/bash

# This script provisions a NAS drive to be mounted

read -p "NAS IP Address: " ip_addr
if grep -q $ip_addr /etc/fstab; then
  echo "This IP is already listed in /etc/fstab"
  return 1
fi

# User must enter the full path from root "/".
read -p "Enter Mount Point, starting from HOME directory (ex: $HOME/Documents/Shared, enter Documents/Shared): " -i "Documents/Shared" -e mnt_point

# If nothing is entered in for the mount point, mnt_point is set to the default value.
if [[ -z  "$mnt_point" ]]; then
  mnt_point="$HOME/Documents/Shared"
fi

# If the mount point is already provisioned in /etc/fstab, the script exits without adding any entry to fstab.
if grep -q "$mnt_point" "/etc/fstab"; then
  echo "Mount point: $mnt_point is already in use"
  return 1
fi

# CDs to $HOME and creates the mount point if it doesn't already exist.
mkdir -p "$mnt_point"

# Collects NAS username and password
read -p "Username: " username
read -s -p "Password: " password

# Adds fstab entry, reloads systemctl, and mounts fstab entries.
echo -e "# Provisions NAS $ip_addr to $mnt_point\n//$ip_addr/Shared $mnt_point cifs uid=1000,gid=1000,username=$username,password=$password 0 0" | sudo tee -a /etc/fstab
echo -e "\n"
sudo systemctl daemon-reload
sudo mount -a
