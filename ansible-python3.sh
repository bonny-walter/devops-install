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

# Function to install Python 3
install_python() {
    echo "Installing Python 3..."
    sleep 2

    # Update package list
    echo "Updating package list..."
    sudo apt-get update -y
    sleep 2

    # Install Python 3
    echo "Installing Python 3..."
    sudo apt-get install -y python3 python3-pip
    sleep 2

    # Verify Python installation
    echo "Verifying Python installation..."
    python3 --version
    sleep 2
}

# Function to install Ansible
install_ansible() {
    echo "Installing Ansible..."
    sleep 2

    # Update package list
    echo "Updating package list..."
    sudo apt-get update -y
    sleep 2

    # Install Ansible
    echo "Installing Ansible..."
    sudo apt-get install -y ansible
    sleep 2

    # Verify Ansible installation
    echo "Verifying Ansible installation..."
    ansible --version
    sleep 2
}

# Main script
if check_os; then
    install_python
    install_ansible
else
    echo "Installation aborted."
fi
