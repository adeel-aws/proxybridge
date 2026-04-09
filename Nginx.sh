#!/bin/bash
# Update the package list
sudo apt update -y

# Install Nginx
sudo apt install nginx -y

# Start and enable Nginx (Ubuntu usually does this automatically, but these ensure it)
sudo systemctl enable nginx
sudo systemctl start nginx

# Add your custom output
# Note: Ubuntu uses /var/www/html/ as the default root
echo "<h1>Welcome to My Private Nginx Server</h1>" | sudo tee /var/www/html/index.html