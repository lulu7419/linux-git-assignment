#!/bin/bash

# Script name: myscript.sh
# Purpose: An ETL script to extract, transform, and load financial data

# -------------------------------------------------------------------
# Environment Variable Setup
# -------------------------------------------------------------------
# The URL must be stored in the environment variable $URL.
# If URL is empty, print a message and stop the script.
if [ -z "$URL" ]; then
  echo "Error: The URL environment variable is not set."
  echo "Please set it first using: export URL='your_link_here'"
  exit 1
fi

echo "Starting the ETL pipeline..."
echo "Using dataset URL from environment variable: $URL"


# -------------------------------------------------------------------
# Stage 1: Extraction
# -------------------------------------------------------------------
echo "Step 1: Creating the 'raw' folder..."
mkdir -p raw

echo "Step 2: Downloading the data with curl..."
curl -o raw/raw_data.csv "$URL"

# Check if the download succeeded and has content
if [ -s "raw/raw_data.csv" ]; then
  echo "Download successful! File saved to raw/raw_data.csv"
else
  echo "Download failed. The raw file is missing or empty."
  exit 1
fi


# -------------------------------------------------------------------
# Stage 2: Transformation
# -------------------------------------------------------------------
echo "Step 3: Creating the 'Transformed' folder..."
mkdir -p Transformed

echo "Step 4: Renaming headers and selecting required columns..."
# Using sed to change Variable_code to variable_code and Year to year
# Using cut to pick columns: 1 (year), 5 (Units), 6 (variable_code), 9 (Value)
sed '1s/Variable_code/variable_code/; 1s/Year/year/' raw/raw_data.csv | cut -d ',' -f 1,5,6,9 > Transformed/2023_year_finance.csv

# Confirm the transformed file was created
if [ -s "Transformed/2023_year_finance.csv" ]; then
  echo "Transformation successful! Here are the first two rows:"
  head -n 2 Transformed/2023_year_finance.csv
else
  echo "Transformation failed. Transformed file was not created."
  exit 1
fi


# -------------------------------------------------------------------
# Stage 3: Load
# -------------------------------------------------------------------
echo "Step 5: Creating the 'Gold' folder..."
mkdir -p Gold

echo "Step 6: Loading the transformed file into the Gold folder..."
cp Transformed/2023_year_finance.csv Gold/2023_year_finance.csv

# Verify the file is in the Gold folder
if [ -s "Gold/2023_year_finance.csv" ]; then
  echo "Load successful! File is ready in Gold directory:"
  ls -l Gold/2023_year_finance.csv
else
  echo "Load failed. File is missing from Gold folder."
  exit 1
fi

echo "ETL pipeline completed successfully!"
