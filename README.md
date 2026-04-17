ATTENDANCE TRACKER SETUP SCRIPT
This Bash script automates the setup of an attendance tracking project environment. It creates a structured workspace, copies necessary files, optionally updates configuration thresholds, validates Python availabilitY and checks the directory structure.

THE SCRIPT PERFOMS THE FOLLOWING ACTIONS:

1. Prompts the user for a name to create a unique workspace directory (`attendance_tracker_<name>`).
2. Copies `attendance_checker.py` into the workspace root.
3. Creates subdirectories `Helpers/` and `reports/`.
4. Copies `assets.csv` and `config.json` into `Helpers/`.
5. Copies `reports.log` into `reports/`.
6. Asks if the user wants to update warning/failure thresholds in `config.json`.
7. Checks if Python 3 is installed and displays its version.
8. Validates that the project directory structure follows the expected layout.

If the script receives a `SIGINT` (Ctrl+C), it archives the workspace as a tarball and removes the original directory before exiting.

REQUIREMENT

-Operating System Linux, macOS or Windows
- Bash (version 4.0+ recommended)
- Python 3 (required only for the `attendance_checker.py` script; the setup script only checks its presence)
- Required files (must be present in the current directory before running the script):
  - `attendance_checker.py`
  - `assets.csv`
  - `config.json`
  - `reports.log`

PREPARATIONy
1. Clone the repository containing this script and the required files.
2. Ensure the script is executable:
   ```bash
   chmod +x setup_project.sh
3. Verify that all required files are in the same directory as the script.

USAGE
Run the script from the terminal
   ```bash
   ./setup_project.sh
You will be guided through the following prompts:
1. Enter a name for the directory – this will be appended to attendance_tracker_ (e.g., attendance_tracker_myproject).
2. Update thresholds? [Y/N] – if yes, you can enter custom values for warning and failure thresholds (defaults: 75 and 50). These are written to Helpers/config.json.
3. The script then runs the Python check and directory validation automatically.

EXAMPLE SESSION
$ ./setup_project.sh
Please enter a name to create a directory: january2026
Do you want to update the thresholds? [Y/N] y
Enter Warning threshold :(Default 75) 80
Enter Failure threshold :(Default 50) 40
Analyzing background
Looking for python in your environment
Success!! Python 3 is present
SUCCESS !!
Project directory structure successfully followed

CONFIGURATION

The script uses sed to modify config.json. The JSON structure should contain the keys warning and failure as numeric values, for example:
{
  "warning": 75,
  "failure": 50
}
If you choose not to update thresholds, the original values from the source config.json are preserved.

LICENSE
This script is provided as-is for educational or internal use. Modify it according to your project’s needs.
