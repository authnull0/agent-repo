#!/bin/bash

# This script downloads the SSP agent, linux agent, pam module on a Linux machine
echo "Downloading the endpoint agent binary..."
curl -L -o agentv2 https://github.com/authnull0/agent-repo/raw/refs/heads/main/linux-agent/agentv2
if [ $? -ne 0 ]; then
    echo "Failed to download the agent binary."
    exit 1
fi
echo "Downloaded the agent binary successfully."

echo "Downloading the ssp agent binary..."
curl -L -o ssp_agent https://github.com/authnull0/agent-repo/raw/refs/heads/main/ssp-agent/ssp_agent
if [ $? -ne 0 ]; then
    echo "Failed to download the ssp agent binary."
    exit 1
fi
echo "Downloaded the ssp agent binary successfully."

echo "Downloading the service file..."
curl -L -o ssp_agent.service https://github.com/authnull0/agent-repo/raw/refs/heads/main/ssp-agent/ssp_agent.service
if [ $? -ne 0 ]; then
    echo "Failed to download the service file."
    exit 1
fi
echo "Downloaded the service file successfully."


echo "Downloading the pam module..."
curl -L -o pam_custom.so https://github.com/authnull0/agent-repo/raw/refs/heads/main/pam-module/pam_custom.so
if [ $? -ne 0 ]; then
    echo "Failed to download the .so file."
    exit 1
fi
echo "Downloaded the .so file successfully."

echo "Donloading did.sh file"
curl -L -o did.sh https://github.com/authnull0/agent-repo/raw/refs/heads/main/pam-module/did.sh
if [ $? -ne 0 ]; then
    echo "Failed to download did.sh file."
    exit 1
fi
echo "Downloaded did.sh file successfully."

echo "Please enter the content for the app.env file. End with an empty line or Ctrl+D:"


# Initialize an empty string to store the content
app_env_content=""

# Read input line by line
while IFS= read -r line || [ -n "$line" ]; do
    # Append the line and a newline character to app_env_content
    app_env_content+="$line"$'\n'
done

# Remove the trailing newline character
app_env_content=${app_env_content%$'\n'}

# Prompt the user for CLIENT_ID and CLIENT_SECRET
echo "Enter CLIENT_ID:"
read -r CLIENT_ID
echo "Enter CLIENT_SECRET:"
read -r CLIENT_SECRET

# Append CLIENT_ID and CLIENT_SECRET with proper formatting
app_env_content+="CLIENT_ID=$CLIENT_ID"$'\n'
app_env_content+="CLIENT_SECRET=$CLIENT_SECRET"$'\n'

# Create the app.env file with the provided content
echo "$app_env_content" > app.env

# Create the app.env file with the provided content
echo -n "$app_env_content" > app.env

# #copy app.env to / directory
# sudo cp app.env /

# Make the agent file executable
sudo chmod +x agentv2

# Run the agent
sudo ./agentv2
