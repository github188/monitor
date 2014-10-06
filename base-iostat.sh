#!/bin/bash
DISKDETECT="./diskdetect.txt"

while read line
do
    DISK=$(echo $line | awk '{print $14}')
    DISKTYPE=$(echo $line | awk '{print $12}')
    ERROR=$(iostat -ern $(cd /dev/rdsk && ls *$DISK) | tail -n1 | awk -F\, '{print $1" "$2" "$3" "$4}')
    echo -ne "$DISK $ERROR\n"
done < $DISKDETECT
