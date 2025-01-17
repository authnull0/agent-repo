#!/bin/bash

# This script downloads the SSP agent, linux agent, pam module on a Linux machine
# Step 1: Download the agent binary
echo "Downloading the agent binary..."
curl -L -o agentv2 https://github.com/authnull0/windows-endpoint/raw/refs/heads/ssp-agent/ssp-agent/ssp_agent
if [ $? -ne 0 ]; then
    echo "Failed to download the agent binary."
    exit 1
fi

curl -L -o ssp_agent https://github.com/authnull0/windows-endpoint/raw/refs/heads/ssp-agent/ssp-agent/ssp_agent
if [ $? -ne 0 ]; then
    echo "Failed to download the agent binary."
    exit 1
fi
echo "Downloaded the ssp agent binary successfully."
# Step 2: Download the service file
echo "Downloading the service file..."
curl -L -o ssp_agent.service https://github.com/authnull0/windows-endpoint/raw/refs/heads/ssp-agent/ssp-agent/ssp_agent.service
if [ $? -ne 0 ]; then
    echo "Failed to download the service file."
    exit 1
fi
echo "Downloaded the service file successfully."

# Step 3: Download the pam module
echo "Downloading the pam module..."
curl -L -o pam_custom.so 
if [ $? -ne 0 ]; then
    echo "Failed to download the service file."
    exit 1
fi
echo "Downloaded the pam module successfully."

echo "Donloading did.sh file"
curl -L -o did.sh
if [ $? -ne 0 ]; then
    echo "Failed to download did.sh file."
    exit 1
fi
echo "Downloaded did.sh file successfully."