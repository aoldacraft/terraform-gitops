#!/bin/bash

# Function to check if SSH process is still running
check_ssh_tunnel() {
    if ps -p $1 > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Initial sleep to avoid immediate retries
sleep 5

# Run the SSH command and retry every 5 seconds if it fails
while true; do
    # Run the SSH command in the background
    ${SSH_TUNNELING_SCRIPT}
    # Store the PID of the SSH command
    SSH_PID=$!

    # Give the SSH command some time to establish the connection
    sleep 5

    # Check if the SSH process is still running
    if check_ssh_tunnel $SSH_PID; then
        echo "SSH tunnel successfully established."
        break
    else
        echo "SSH tunnel failed to establish. Retrying in 5 seconds..."
        sleep 5
    fi
done
