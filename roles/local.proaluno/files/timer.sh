#!/bin/bash

# last | grep "still logged in"
old=$(w -h | grep $(whoami) | head -1 | tr -s ' '| cut -d' ' -f4)
new=$(date +"%H:%M")

# https://stackoverflow.com/questions/14309032/bash-script-difference-in-minutes-between-two-times

IFS=: read old_hour old_min <<< "$old"
IFS=: read hour min <<< "$new"

# convert the date "1970-01-01 hour:min:00" in seconds from Unix EPOCH time
sec_old=$(date -d "1970-01-01 $old_hour:$old_min:00" +%s)
sec_new=$(date -d "1970-01-01 $hour:$min:00" +%s)

echo $(( (sec_new - sec_old) / 60))
