#!/bin/bash

# A simple script to move CSV and JSON files to a folder called json_and_CSV

# Step 1: Create the destination folder
echo "Creating the json_and_CSV folder..."
mkdir -p json_and_CSV

# Step 2: Check if there are any CSV files and move them
if ls source_data/*.csv 1> /dev/null 2>&1; then
  echo "Moving CSV files..."
  mv source_data/*.csv json_and_CSV/
else
  echo "No CSV files found to move."
fi

# Step 3: Check if there are any JSON files and move them
if ls source_data/*.json 1> /dev/null 2>&1; then
  echo "Moving JSON files..."
  mv source_data/*.json json_and_CSV/
else
  echo "No JSON files found to move."
fi

# Step 4: Show the files in the new folder
echo "Done! Here are the files in json_and_CSV:"
ls -l json_and_CSV
