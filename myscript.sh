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

##===================================================================
## Transformation
#1. create directory called Transformed

mkdir -p Transformed
 ls  Transformed


# 2.rename the column and pick the 4 columns
sed '1s/Variable_code/variable_code/' raw/*.cvs | cut -d ',' -f 1,3,4,5 >Transformed/2023_year_finance.csv
 
# 3. confirm the file is in the folder
 ls -l Transformed/2023_year_finance.csv


