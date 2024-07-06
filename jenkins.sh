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

# Function to check if Java is installed
check_java() {
    echo "Checking if Java is installed..."
    sleep 2

    if command -v java &> /dev/null; then
        echo "Java is already installed."
        return 0
    else
        echo "Java is not installed."
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
    echo "Installing Java 17..."
    sudo apt-get install -y openjdk-17-jdk
    sleep 2

    # Verify Java installation
    echo "Verifying Java installation..."
    java -version
    sleep 2
}

# Function to install Jenkins
install_jenkins() {
    echo "Installing Jenkins..."
    sleep 2

    # Update package list
    echo "Updating package list..."
    sudo apt-get update -y
    sleep 2

    # Install prerequisites
    echo "Installing prerequisites..."
    sudo apt-get install -y gnupg2
    sleep 2

    # Add Jenkins repository
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null 
    sudo apt-get update
    # install jenkins
    echo "installing jenkins"
    sudo apt-get install -y jenkins  
    sleep 2

    

    # Start Jenkins
    echo "Starting Jenkins..."
    sudo systemctl start jenkins
    sleep 2

    # Enable Jenkins to start on boot
    echo "Enabling Jenkins to start on boot..."
    sudo systemctl enable jenkins
    sleep 2

    # Verify Jenkins installation
    echo "Verifying Jenkins installation..."
    sudo systemctl status jenkins
    sleep 2
}

# Main script
if check_os; then
    if check_java; then
        install_jenkins
    else
        install_java
        install_jenkins
    fi
else
    echo "Installation aborted."
fi
