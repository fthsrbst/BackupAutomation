Linux Backup Automation

This project automates the process of backing up files from a specific source directory. Backups are created every 24 hours, and old backups (older than 30 days) are automatically deleted. You can also schedule the backup process using a cron job to run daily.

Features
	•	Backs up files from the source directory (source_path) and stores them in the destination directory (destination_path).
	•	Backup files are created in .tar format.
	•	No new backup is created if the last backup is less than 24 hours old.
	•	Old backups (older than 30 days) are automatically deleted.
	•	The backup process can be scheduled using a cron job to run daily.

Requirements
	•	jq: jq is required to process JSON files. If it’s not installed on your system, you can install it with the following command:
For macOS (using Homebrew):

	brew install jq

For Ubuntu/Debian:

	sudo apt-get install jq



Installation

1. Clone the repository:

```bash
git clone https://github.com/fthsrbst/BackupAutomation.git
```
```bash
cd repository
```


2. Run the Configuration Change Scripts:
First, run the change_dir.sh script to update the source directory:
```
./change_dir.sh
```
Then, run the change_dest.sh script to update the destination directory:

	./change_dest.sh


3. Set up the Cron Job:
After updating the directories, you can set up the cron job using the setup_backup_cron.sh script:
```
./setup_backup_cron.sh
```
This script checks for an existing cron job and adds one if it’s not already present.

4. Make the Scripts Executable:
Give execute permissions to backup_script.sh, change_dir.sh, change_dest.sh, and setup_backup_cron.sh:
```
chmod +x backup_script.sh change_dir.sh change_dest.sh setup_backup_cron.sh
```

5. Manual Backup:
To start the backup process immediately, run the backup_script.sh file:
```
./backup_script.sh
```


File Structure
    • backup_script.sh: The main script for the backup process.
    • change_dir.sh: The script for changing the source directory path in config.json.
    • change_dest.sh: The script for changing the destination directory path in config.json.
    • setup_backup_cron.sh: The script for adding and managing the cron job.
    • config.json: The configuration file containing the source and destination directory information for the backup.
    • backup_cron.log: The log file where cron job outputs will be recorded.
    • change_ui.py: A script for managing the backup settings through a user-friendly interface.
    
Troubleshooting
	•	jq not found error: This indicates that the jq command-line tool needs to be installed. Follow the installation instructions from the Requirements section above.
	•	Backup not working: Ensure that the source and destination directory paths are correct. Also, verify that the script files have executable permissions and the necessary permissions to write to the destination directory.

Contributing

If you’d like to contribute, please submit a pull request. Include a clear and concise commit message describing your changes.
