#!/bin/bash

# The purpose of this bash shell script is to run a sequence of queries or batches of queries.
# The first version runs these queries in sequence.
# Run parallel processes and wait for their completion
# Installation:
#   1. Copy this shell script to a server with Hive installed
#   2. Use the following command to exceute this script: ./hive_query_csv_export.sh

# Version 1: sequence of queries
# Add loop here or add more calls
hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example1.csv 
wait
hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example2.csv
wait
hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example3.csv

# Version 2: Batch processing option.
# the first and second queries are started simultaneously then the second batch of queries start.
# hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example1.csv &
# hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example2.csv &
# wait
# hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example3.csv &
# hive -e "SELECT column FROM db.table LIMIT 5;" | tr "\t" "," > example4.csv

# Note that adding an ampersand in above commands says to create parallel processes
# A hive call can also be wrapped in a function that does logging, etc.
# And call a function as parallel process in the same way
# Modify this script to fit your needs

# Now wait for all processes to complete

# Failed processes count
FAILED=0

# bash code that returns an error message if there is a failure
for job in `jobs -p`
do
   echo "job=$job"
   wait $job || let "FAILED+=1"
done   

# Final status check
if [ "$FAILED" != "0" ]; then
    echo "Execution FAILED!  ($FAILED)"
    # Do something here, log or send messege, etc
    exit 1
fi

# Normal exit
# Option to do something else here
exit 0
