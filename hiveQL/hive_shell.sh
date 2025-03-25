#!/bin/bash
## By Andrew Young 
## Contact: andrew.wong@team.neustar
## Last modified date: 13 Dec 2019
################
## DIRECTIONS ##
################
## Run the following <commands> without the "<" or ">".
## <chmod u+x scriptname> to make the script executable. (where scriptname is the name of your script)
## To run this script, use the following command:
## ./temp.sh
#################################
## Ask user for Hive file name ##
#################################
echo Hello. Please enter the HiveQL filename with the file extension. For example, 'script.hql'. To cancel, press 'Control+C'. For your convenience, here is a list of files in the present directory\:
ls -l
read -p 'Enter the HiveQL filename: ' HIVE_FILE_NAME
#read HIVE_FILE_NAME
echo You specified: $HIVE_FILE_NAME
echo Executing...
######################
## Define variables ##
######################
start="$(date)"
starttime=$(date +%s)
#####################
## Run Hive script ##
#####################
hive -f "$HIVE_FILE_NAME"
#################################
## Human readable elapsed time ##
#################################
secs_to_human() {
    if [[ -z ${1} || ${1} -lt 60 ]] ;then
        min=0 ; secs="${1}"
    else
        time_mins=$(echo "scale=2; ${1}/60" | bc)
        min=$(echo ${time_mins} | cut -d'.' -f1)
        secs="0.$(echo ${time_mins} | cut -d'.' -f2)"
        secs=$(echo ${secs}*60|bc|awk '{print int($1+0.5)}')
    fi
    timeelapsed="Clock Time Elapsed : ${min} minutes and ${secs} seconds."
}
################
## Send email ##
################
end="$(date)"
endtime=$(date +%s)
secs_to_human $(($(date +%s) - ${starttime}))
subject="$HIVE_FILE_NAME started @ $start || finished @ $end"
## message="Note that $start and $end use server time. \n $timeelapsed"
## working version:
mail -s "$subject" youremail@wherever.com <<< "$(printf "
Server start time: $start \n
Server   end time: $end   \n
$timeelapsed")"
#################
## FUTURE WORK ##
#################
# 1. Add a diagnostic report. The report will calculate:
#    a. number of rows,
#    b. number of distinct observations for each column,
#    c. an option for a cutoff threshold for observations that ensures the diagnostic report is only produced for tables of a certain size. this can help prevent computationally expensive diagnostics for a large table
#
# 2. Option to save output to a text file for inclusion in email notification.
#################
