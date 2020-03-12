#!/bin/bash

# ----------- How to use script -----------
# First parameter is name of web server (nginx or apache)
# Second parameter is X of top IP addresses
# Third parameter is Y of URLs

path_to_access_log () {
    find /var/log/ -name 'access.log' | grep $1
}

get_last_hour_from_log () {
    grep "^$(date -d '-1 hour' +'%H')" $1
}

# prevent multiple script running
lock_file=/tmp/lock
if [ -f $lock_file ]; then
    echo "script already started"
    exit 6
fi
touch $lock_file
trap 'rm -f "$lock_file"; exit $?' INT TERM EXIT

DATE_TIME=$(date '+%Y-%m-%d-%H-%M-%S')
REPORT=report_"${DATE_TIME}"
LOG_PATH=$(path_to_access_log $1)
LAST_HOUR_LOG=$(get_last_hour_from_log $LOG_PATH)

# get X of top IP addresses
echo $LAST_HOUR_LOG | awk '{print $1}' | sort | uniq -c | sort -nr | head -n $2 > top_ip

# get Y of top URLs
echo $LAST_HOUR_LOG | awk '{print $7}' | sort | uniq -c | sort -rn | head -n $3 > top_urls

# get all errors
echo $LAST_HOUR_LOG | awk '{print $9}' | grep ^4 > errors4xx
echo $LAST_HOUR_LOG | awk '{print $9}' | grep ^5 > errors5xx

# get all http codes
echo $LAST_HOUR_LOG | awk '{print $9}'| grep -v "-" | sort | uniq -c | sort -rn > http_codes

# create report
cat top_ip top_urls errors4xx errors5xx http_codes > report_$DATE_TIME

sendmail -t aleksandr@demsh.in -m "You recieved last hour report $REPORT" -a report_$DATE_TIME

# clear tmp files
rm top_ip top_urls errors4xx errors5xx http_codes report_$DATE_TIME
