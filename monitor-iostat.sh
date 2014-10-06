#!/bin/bash
DISKDETECT="$HOME/monitor/diskdetect.txt"
ERRFOUND=""
while read line
do
    DISK=$(echo $line | awk '{print $14}')
    DISKTYPE=$(echo $line | awk '{print $12}')
    ERRORS=$(iostat -ern $DISK | tail -n1 | awk -F\, '{print $1" "$2" "$3" "$4}')
    #s/w h/w trn tot    
    ERRSW=$(echo $ERRORS | awk '{print $1}')
    ERRHW=$(echo $ERRORS | awk '{print $2}')
    ERRTRN=$(echo $ERRORS | awk '{print $3}')
    ERRTOT=$(echo $ERRORS | awk '{print $4}')
    if [ $ERRSW -gt 0 ] 
    then
     ERRFOUND="${ERRFOUND}Software error detected on $DISK - count $ERRSW\n"
    fi  
    if [ $ERRHW -gt 0 ] 
    then
     ERRFOUND="${ERRFOUND}Hardware error detected on $DISK - count $ERRHW\n"
    fi  
    if [ $ERRTRN -gt 0 ] 
    then
     ERRFOUND="${ERRFOUND}Transport error detected on $DISK - count $ERRTRN\n"
    fi  
    if [ $ERRTOT -gt 0 ] 
    then
     ERRFOUND="${ERRFOUND}Total errors detected on $DISK - count $ERRTOT\n"
    fi
done < $DISKDETECT

#when errors found - give output
if [ ! -z "$ERRFOUND" ]
then
    echo $ERRFOUND
fi
