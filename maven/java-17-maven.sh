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

# Function to install Java 17
install_java() {
    echo "Installing Java 17..."
    sleep 2

    # Update package list
    echo "Updating package list..."
    sudo apt-get update -y
    sleep 2

    # Install Java 17
    echo "Installing OpenJDK 17..."
    sudo apt-get install -y openjdk-17-jdk
    sleep 2

    # Verify Java installation
    echo "Verifying Java installation..."
    java -version
    sleep 2
}

# Function to install Maven
install_maven() {
    echo "Installing Maven..."
    sleep 2

    # Update package list
    echo "Updating package list..."
    sudo apt-get update -y
    sleep 2

    # Install Maven
    echo "Installing Maven..."
    sudo apt-get install -y maven
    sleep 2

    # Verify Maven installation
    echo "Verifying Maven installation..."
    mvn -version
    sleep 2
}

# Main script
if check_os; then
    install_java
    install_maven
else
    echo "Installation aborted."
fi
