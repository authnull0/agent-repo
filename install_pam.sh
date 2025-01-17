#!/bin/bash

# This script deploys the pam module in a linux machine

#Copying the pam module to /lib/x86_64-linux-gnu/security/
echo "Copying pam_custom.so to /lib/x86_64-linux-gnu/security/"
sudo cp pam_custom.so /lib/x86_64-linux-gnu/security/.
if [ $? -eq 0 ]; then
    echo "pam_custom.so successfully copied."
else
    echo "Failed to copy pam_custom.so. Check permissions or file existence." >&2
    exit 1
fi


# opy the did.sh file to the root directory
echo "Copying did.sh to /"
sudo cp did.sh /
if [ $? -eq 0 ]; then
    echo "did.sh successfully copied."
else
    echo "Failed to copy did.sh. Check permissions or file existence." >&2
    exit 1
fi

#CConfigure the sshd_config file
echo "Configuring /etc/ssh/sshd_config..."

if grep -q "^KbdInteractiveAuthentication no" /etc/ssh/sshd_config; then
    sudo sed -i 's/^KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/g' /etc/ssh/sshd_config
fi

if grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
fi

if ! grep -q "AuthenticationMethods keyboard-interactive" /etc/ssh/sshd_config; then
    sudo sh -c 'echo "AuthenticationMethods keyboard-interactive" >> /etc/ssh/sshd_config'
fi

#Configure the pam.d/sshd file
echo "configuring /etc/pam.d/sshd..."

if ! grep -q "auth            sufficient              /lib/x86_64-linux-gnu/security/pam_custom.so" /etc/pam.d/sshd; then
    sudo sh -c 'echo "auth            sufficient              /lib/x86_64-linux-gnu/security/pam_custom.so" >> /etc/pam.d/sshd'

fi

#Restart the sshd service
echo "Restarting sshd service..."
sudo systemctl restart sshd
if [ $? -eq 0 ]; then
    echo "sshd service restarted successfully."
else
    echo "Failed to restart sshd service." >&2
    exit 1
fi

# Log the SSH service restart status
echo "SSH service restart attempted. Check the logs with: tail -f /var/log/auth.log (Ubuntu) or tail -f /var/log/secure (CentOS)"