#!/bin/bash

# Check if argument was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1

# Check if user exists in /etc/passwd
if grep -q "^$USERNAME:" /etc/passwd; then
    echo "User $USERNAME exists"
    exit 0
else
    echo "User $USERNAME not found"
    exit 1
fi
