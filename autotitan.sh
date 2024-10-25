#!/bin/bash

# Remove the .titanedge directory if it exists
echo "Removing ~/.titanedge directory if it exists..."
rm -rf ~/.titanedge

# Pull the latest Docker image
echo "Pulling Docker image nezha123/titan-edge..."
docker pull nezha123/titan-edge

# Create the .titanedge directory
echo "Creating ~/.titanedge directory..."
mkdir -p ~/.titanedge

# Run the main Docker container
echo "Starting Docker container with volume and network settings..."
docker run --network=host -d -v ~/.titanedge:/root/.titanedge nezha123/titan-edge

# Wait for 10 seconds before running the bind command
echo "Waiting for 10 seconds..."
sleep 10

# Prompt user for hash input
read -p "Please enter the hash: " user_hash

# Check if the container is running
container_id=$(docker ps -q --filter ancestor=nezha123/titan-edge)

if [ -z "$container_id" ]; then
    echo "Error: Titan Edge container is not running."
    exit 1
fi

# Run the binding command with user-provided hash
echo "Binding device with hash: $user_hash"
docker run --rm -it -v ~/.titanedge:/root/.titanedge nezha123/titan-edge bind --hash="$user_hash" https://api-test1.container1.titannet.io/api/v2/device/binding

echo "Titan Edge setup complete."
