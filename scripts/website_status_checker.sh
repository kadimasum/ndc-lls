#!/bin/bash

# Website Status Checker Script
# This script checks if a list of websites are online or offline.

WEBSITES=("https://www.google.com" "https://www.github.com" "https://www.nonexistentwebsite.com")
STATUS_FILE="website_status.log"

# Function to check website status
check_website_status() {
    for WEBSITE in "${WEBSITES[@]}"; do
        STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" $WEBSITE)
        
        if [ "$STATUS_CODE" -eq 200 ]; then
            echo "$WEBSITE is online." >> $STATUS_FILE
        else
            echo "$WEBSITE is offline (HTTP Status: $STATUS_CODE)." >> $STATUS_FILE
        fi
    done
}

# Main script execution
echo "Starting website status check..."
check_website_status
echo "Website status check complete. Results stored in $STATUS_FILE."
