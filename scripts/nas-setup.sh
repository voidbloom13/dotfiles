#!/bin/bash

# This script provisions a NAS drive to be mounted

read -p "NAS IP Address: " ip_addr
if grep -q $ip_addr /etc/fstab; then
  echo "This IP is already listed in /etc/fstab"
  return 1
fi

# User must enter the full path from root "/".
read -p "Enter full path to mount point: " -i "/home/Shared" -e mnt_point

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
read -p "IP: $ip_addr\nMount Point: $mnt_point\nIs this correct? [Y]es [N]o : " is_correct
case "$is_correct" in
  [Yy]|[Yy][Ee][Ss]) 
    echo -e "# Provisions NAS $ip_addr to $mnt_point\n//$ip_addr/Shared $mnt_point cifs uid=1000,gid=1000,username=$username,password=$password 0 0" | sudo tee -a /etc/fstab
    echo -e "\n"
    sudo systemctl daemon-reload
    sudo mount -a
  ;;
  *)
    echo "Provisioning failed. Please manually edit /etc/fstab or run $HOME/dotfiles/scripts/nas-setup.sh."
    return 1
  ;;
esac

