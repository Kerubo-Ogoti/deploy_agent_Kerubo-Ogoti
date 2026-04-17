#!/usr/bin/env bash
set -e # The script will stop if there is a problem 
stopscript_and_archive(){
echo -e "\n The script is been stopped "
if [ -d "$master_dir" ]; then
echo -e "\n Creating archive"	
tar -cvf "${master_dir}_archive" "$master_dir"
rm -rf "$master_dir"
echo -e "The directory has been up \n Workspace archived as ${master_dir}_archive"
fi
exit 1
}
# The function stopscript_and_archive will be invoked whenever a SIGINT signal is received
trap stopscript_and_archive SIGINT
# asking the user to enter a name that will be used to form part of the parent directory that will be created later
read -p "Please  enter a name to create a directory :
" input_of_the_user
mkdir attendance_tracker_"$input_of_the_user"
master_dir=attendance_tracker_"$input_of_the_user"
cp attendance_checker.py $master_dir/
mkdir -p $master_dir/Helpers
cp {assets.csv,config.json} $master_dir/Helpers/
mkdir -p $master_dir/reports
cp reports.log $master_dir/reports/
# Asking the user if they want to update the threshold values in the config.json file
read -p "Do you want to update the thresholds ? [Y/N]
" Answer
if [[ "$Answer" =~ ^[Yy]$ ]]; then 
read -p "Enter Warning threshold :(Default 75)
" warn_value
read -p "Enter Failure threshold :(Default 50)
" failed_value
# Use sed command with the -i flag to directly make updates in the config.json file
    sed -i "s/\(\"warning\":\)[[:space:]]*[0-9]*/\1 ${warn_value:-75}/" "$master_dir/Helpers/config.json"
    sed -i "s/\(\"failure\":\)[[:space:]]*[0-9]*/\1 ${failed_value:-50}/" "$master_dir/Helpers/config.json"
fi
echo "Analyzing background"
echo "Looking for python in your environment"
if python3 --version &>/dev/null; then
echo "Success!! $(python3 --version) is present"
else 
echo "Not found!! .python is absent .Please install"
fi
# validating correct project directory setup
if [ -f "$master_dir/attendance_checker.py" ] && [ -d "$master_dir/Helpers" ] && [ -d "$master_dir/reports" ]; then
echo -e "SUCCESS !! \n Project directory structure successfully followed"
else
echo -e "FAIL !! \n Project directory structure has not been followed"
fi
