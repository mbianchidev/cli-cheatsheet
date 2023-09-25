#!/bin/bash

# A kinda complex way to install it, for the lazy people like me that don't want to do it manually at all

TF_DOC_URL="https://learn.hashicorp.com/tutorials/terraform/install-cli"

# Function to check if a command is available, kinda clunky but w/e
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a package using apt-get and updating each time (slow? maybe)
install_with_apt() {
    sudo apt-get update
    sudo apt-get install -y "$1"
}

install_with_brew() {
    brew tap --repair
    brew update
    brew install "$1"
}

install_with_yum() {
    sudo yum update
    sudo yum install -y "$1"
}

install_with_dnf() {
    sudo dnf update
    sudo dnf install -y "$1"
}

install_with_zypper() {
    sudo zypper update
    sudo zypper install -y "$1"
}

install_req() {
    # Also sets the package manager variable
    if check_command "apt-get"; then
        PACKAGE_MANAGER="apt-get"
    elif check_command "brew"; then
        PACKAGE_MANAGER="brew"
    elif check_command "yum"; then
        PACKAGE_MANAGER="yum"
    elif check_command "dnf"; then
        PACKAGE_MANAGER="dnf"
    elif check_command "zypper"; then
        PACKAGE_MANAGER="zypper"
    else
        echo "Error: Unsupported package manager found."
        return 1
    fi

    packages=("$@")

    for package in "${packages[@]}"; do
        if ! check_command "$package"; then
            case $PACKAGE_MANAGER in
                "apt-get")
                    install_with_apt "$package"
                    ;;
                "yum")
                    install_with_yum "$package"
                    ;;
                "dnf")
                    install_with_dnf "$package"
                    ;;
                "zypper")
                    install_with_zypper "$package"
                    ;;
            esac
        fi
    done
}

check_install_brew() { 
    if ! check_command "brew"; then
        echo "Homebrew is not installed. Installing it now."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Install required packages and updates your packages
install_req "wget"

# Function to prompt for user input, could it be done better? probably
get_architecture() {
    echo "Select your system architecture:"
    echo "0. Exit"
    echo "1. x64"
    echo "2. ARM"
    read -p "Enter the number corresponding to your choice: " choice

    case $choice in
        0)
            ARCHITECTURE="Unknown"
            ARCH="Unknown"
            ;;
        1)
            ARCHITECTURE="x64"
            ARCH="amd64"
            ;;
        2)
            ARCHITECTURE="ARM"
            ARCH="arm64"
            ;;
        *)
            echo "Invalid choice. Please select 1 or 2 (or 0 to exit)."
            get_architecture
            ;;
    esac
}

get_bash_config_file() {
    echo "Select your bash config file:"
    echo "0. Exit"
    echo "1. ~/.bashrc"
    echo "2. ~/.zshrc"
    read -p "Enter the number corresponding to your choice: " choice

    case $choice in
        0)
            BASH_CONFIG=""
            ;;
        1)
            BASH_CONFIG="~/.bashrc"
            ;;
        2)
            BASH_CONFIG="~/.zshrc"
            ;;
        *)
            echo "Invalid choice. Please select 1 or 2 (or 0 to exit)."
            get_bash_config_file
            ;;
    esac
}

# Get current directory and save it
CURRENT_DIR=$(pwd)
# Change to the home directory
cd ~

# Prompt the user for architecture choice
get_architecture

# Prompt the user for bash config choice
get_bash_config_file

get_os_info() {
    if [ -f "/etc/os-release" ]; then
        # Get the OS information from /etc/os-release
        source /etc/os-release
        OS_NAME="$NAME"
        OS_VERSION="$VERSION_ID"
        case "$ID" in
            ubuntu | debian)
                OS_TYPE="Debian/Ubuntu"
                ;;
            centos | rhel)
                OS_TYPE="RHEL/CentOS"
                ;;
            opensuse | opensuse-leap)
                OS_TYPE="Suse"
                ;;
            fedora)
                OS_TYPE="Fedora"
                ;;
            *)
                OS_TYPE="Unknown"
                ;;
        esac
    elif [ -f "/etc/redhat-release" ]; then
        # Check for RHEL/CentOS based on the /etc/redhat-release file
        OS_NAME="Red Hat Enterprise Linux or CentOS"
        OS_VERSION=$(cat /etc/redhat-release | grep -oE '[0-9]+\.[0-9]+' | head -1)
        OS_TYPE="RHEL/CentOS"
    elif [ -f "/etc/debian_version" ]; then
        # Check for Debian based on the /etc/debian_version file
        OS_NAME="Debian"
        OS_VERSION=$(cat /etc/debian_version)
        OS_TYPE="Debian/Ubuntu"
    elif [ -f "/etc/SuSE-release" ]; then
        # Check for Suse based on the /etc/SuSE-release file
        OS_NAME="OpenSuse"
        OS_VERSION=$(cat /etc/SuSE-release | grep -oE '[0-9]+\.[0-9]+' | head -1)
        OS_TYPE="Suse"
    else
        # Unable to determine the OS type
        OS_NAME="Unknown"
        OS_VERSION="Unknown"
        OS_TYPE="Unknown"
    fi
}

# Call the function to get the OS information
get_os_info

PLATFORM=$(uname -s)_$ARCH

echo "Detected OS type: $OS_TYPE"
echo "OS Name: $OS_NAME"
echo "OS Version: $OS_VERSION"
echo "Architecture: $ARCHITECTURE"
echo "Platform: $PLATFORM"
echo "Package manager: $PACKAGE_MANAGER"

if ! check_command "terraform"; then
    case $OS_TYPE in 
        "Debian/Ubuntu")
            sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
            wget -O- https://apt.releases.hashicorp.com/gpg | \
            gpg --dearmor | \
            sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
            gpg --no-default-keyring \
            --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
            --fingerprint
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
            https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
            sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt-get install terraform
            ;;
        "RHEL/CentOS")
            el_version=""
            case "$OS_VERSION" in
                7)
                    echo "Running RHEL/CentOS version 7"
                    el_version="el7"
                    ;;
                8)
                    echo "Running RHEL/CentOS version 8"
                    el_version="el8"
                    ;;
                9)
                    echo "Running RHEL/CentOS version 9"
                    el_version="el9"
                    ;;
            esac
            sudo yum install -y yum-utils
            sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
            sudo yum -y install terraform
            ;;
        "Fedora")
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
            sudo dnf -y install terraform
            ;;
        *) #every other case
        check_install_brew
        brew tap hashicorp/tap
        brew install hashicorp/tap/terraform
        ;;
    esac
    terraform -install-autocomplete
    echo "Terraform (should be) installed. If something went wrong, please install it manually referring to the doc: $TF_DOC_URL"
    source $BASH_CONFIG
fi