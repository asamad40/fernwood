#!/bin/bash

echo "Creating new user..."
sudo useradd Precious

echo "Adding user to group..."
sudo usermod -aG sudo Precious

echo "Creating file..."
touch preciousfile.txt

echo "Assigning file ownership to Precious..."
sudo chown Precious preciousfile.txt

echo "Setting permissions - owner read only..."
sudo chmod 400 preciousfile.txt

echo "Current permissions:"
ls -l
