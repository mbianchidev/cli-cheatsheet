#!/bin/bash

# Function to check if a command is available, kinda clunky but w/e
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to update all the things
udpate() {
    echo "Updating..."
    if check_command "apt-get"; then
        echo "Updating apt-get..."
        sudo apt-get update
    fi
    if check_command "yum"; then
        echo "Updating yum..."
        sudo yum update
    fi
    if check_command "brew"; then
        echo "Updating brew..."
        brew tap --repair
        brew update
    fi
    if check_command "npm"; then
        echo "Updating npm..."
        npm update -g
    fi
    if check_command "pip"; then
        echo "Updating pip..."
        pip install --upgrade pip
    fi
    if check_command "gem"; then
        echo "Updating gem..."
        gem update
    fi
    echo "Update finished"
}

update