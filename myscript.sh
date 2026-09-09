#!/bin/bash



#script name: myscript.sh
# Description: A basic bash demonstrating  scriptying concepts
#===================================================================
# Extraction
# 1. create the directory called raw to store data
echo " [info] ensuring 'raw' directory exists
mkdir -p raw

# 2. download csv file from enviroment variable link and save in a file called raw
echo "[INFO] Downloading dataset from source URL..."
curl -o raw/raw_data.csv "$URL"
 
# Confirm file was downloaded and contains data
if [ -s "raw/raw_data.csv" ]; then
    echo "[SUCCESS] File successfully saved to 'raw/raw_data.csv'."
else
    echo "[ERROR] Extraction failed: 'raw/raw_data.csv' is missing or empty."
    exit 1
fi
