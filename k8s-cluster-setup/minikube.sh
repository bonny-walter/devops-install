#!/bin/bash

# Function to check OS type and version
check_os() {
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

# Function to install Minikube
install_minikube() {
    echo "Installing Minikube..."

    # Update package list and install prerequisites
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl

    # Download the latest Minikube binary
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

    # Install Minikube
    sudo install minikube /usr/local/bin/

    # Clean up
    rm minikube

    echo "Minikube installation completed."
}

# Main script
if check_os; then
    install_minikube
else
    echo "Minikube installation aborted."
fi
