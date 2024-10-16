  GNU nano 4.8                                        updateManager.sh                                                 
#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Upgrade all packages
echo "Upgrading all packages..."
sudo apt upgrade -y

# Full upgrade (handles kernel updates and dependencies)
echo "Running full upgrade..."
sudo apt full-upgrade -y

# Remove unused packages
echo "Removing unnecessary packages..."
sudo apt autoremove -y

echo "System updated successfully!"
