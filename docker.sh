#!/bin/bash

# Function to check OS type and version
check_os() {
    echo "Checking operating system type..."
    sleep 2

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [[ -f /etc/os-release ]]; then
            . /etc/os-release
            if [[ "$ID" == "ubuntu" ]]; then
                echo "Operating system is Ubuntu."
                return 0
            else
                echo "Operating system is Linux but not Ubuntu."
                return 1
            fi
        else
            echo "Cannot determine Linux distribution."
            return 1
        fi
    else
        echo "Operating system is not Linux."
        return 1
    fi
}

# Function to install Docker
install_docker() {
    echo "Installing Docker..."
    sleep 2

    # Update package list
    echo "Updating package list..."
    sudo apt-get update -y
    sleep 2

    # Install prerequisites
    echo "Installing prerequisites..."
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    sleep 2

    # Add Docker's official GPG key
    echo "Adding Docker's official GPG key..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    sleep 2

    # Set up the stable repository
    echo "Setting up Docker's stable repository..."
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sleep 2

    # Update the package list again
    echo "Updating the package list again..."
    sudo apt-get update -y
    sleep 2

    # Install Docker
    echo "Installing Docker..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sleep 2

    # Start and enable Docker service
    echo "Starting and enabling Docker service..."
    sudo systemctl start docker
    sudo systemctl enable docker
    sleep 2

    echo "Docker installation completed."
}

# Main script
if check_os; then
    install_docker
else
    echo "Docker installation aborted."
fi
