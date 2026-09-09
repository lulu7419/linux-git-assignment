cat << 'EOF' > README.md
# Linux and Git Assignment

This project contains two Bash scripts and complete documentation for an automated data engineering pipeline and file management workflow.

---

##Project Structure

* myscript.sh`**: Main ETL script (Extract, Transform, Load).
* move_files.sh`**: File handling script to batch-move `.csv` and `.json` files.
* *.gitignore` **: Excludes generated data directories from Git version control.
* **`README.md`**: Complete project documentation and answers to assignment questions.

---

## 1. ETL Pipeline (`myscript.sh`)

This script processes annual financial survey data across three stages:

1. **Extract**: Reads a remote CSV dataset URL from the `$URL` environment variable and saves it to `raw/raw_data.csv`.
Then it calls the URL in the script

2. **Transform**:
   The Variable_code`was changed to `variable_code and   `Year`was changed to `year`. Using the sed command 
  columns 1, 5, 6, and 9 (`year`, `Units`, `variable_code`, `Value`). Were selected using the cut command
   The file was saved as  2023_year_finance.csv` in the Tranformed folder.
3. **Load**: 
 The transformed was loaded into the Gold directory `Gold/2023_year_finance.csv`.

#How to Run:
```bash
export URL="[https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv](https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv)"
bash myscript.sh

2. Assignment Question: Scheduling with Cron 
I wasn’t able to run a cron job as I use a Windows laptop, but this is how i would have done it
Step 1
Make the script executable using the chimod command
chmod +x /c/Users/USER/Desktop/linux-git/myscript.sh

Step 2: The script will be tested manually
/c/Users/USER/Desktop/linux-git/myscript.sh

Step 3: Open crontab
crontab -e
Step 4: Add cron Job
0 0 * * * /c/Users/USER/Desktop/linux-git/myscript.sh

Step 5: Save and Edit
 Using nano: Ctrl + X, then Y, then Enter 

Step 6: Verify the scheduled job
crontab -l

Step 7: Add logging
0 0 * * * /c/Users/USER/Desktop/linux-git/myscript.sh >> /c/Users/USER/Desktop/linux-git/script.log 2>&1


Question 3

# File Moving Script (`move_files.sh`)

This is a simple Bash script to move CSV and JSON files from one folder to another.

---

## What the Script Does

The goal of this script is to look inside a folder named `source_data` and move any `.csv` and `.json` files it finds into a new folder named `json_and_CSV`.

It is written so that: It works with one file or many files.

---
## Sample Files Used for Testing

To test the script,  4 dummy files were created inside `source_data`:

1. `users.csv` - A simple table with user names and roles.
2. `sales.csv` - A simple table with product prices.
3. `config.json` - A small JSON file with project settings.
4. `response.json` - A small JSON file simulating API output.

---

## How the Script Works (Step-by-Step)

1. Creates the new folder:
   It runs `mkdir -p json_and_CSV` so the folder is ready. The `-p` flag prevents errors if the folder already exists.

2. Checks and moves CSV files:
   It checks if any `.csv` files exist. If they do, it moves them using `mv`. If not, it just prints a message saying no CSV files were found.

3. Checks and moves JSON files:
   It does the same check for `.json` files and moves them over.

4. **Shows the results:**  
   It runs `ls -l json_and_CSV` at the end so you can immediately see that the files arrived safely.

---

##  To Test and Run It

### Step 1: Create sample files
```bash
mkdir -p source_data
echo "id,name,role" > source_data/users.csv
echo "product,price" > source_data/sales.csv
echo '{"status": "success", "code": 200}' > source_data/response.json
echo '{"project": "ETL", "active": true}' > source_data/config.json


