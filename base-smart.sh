#!/bin/bash
DISKDETECT="./diskdetect.txt"
#SMARTTMP="/tmp/smart.txt"
# function to translate sas/sata to smartctl values
devicetype () {
        case $1 in
        SATA)
                echo "sat"
                ;;  
        SAS)
                echo "scsi"
                ;;  
esac
}

while read line
do
    DISK=$(echo $line | awk '{print $14}')
    DISKTYPE=$(echo $line | awk '{print $12}')
    iostat -En $DISK | head -n 2
    sudo smartctl -a -d $(devicetype $DISKTYPE) /dev/rdsk/$DISK | /usr/gnu/bin/grep -E 'SMART overall|SMART Health Status|Wear_Leveling_Count|Current_Pending_Sector|Offline_Uncorrectable|Reallocated_Sector_Ct|Error_Rate|SSD_Life_Left|Temperature|endurance indicator|Power_On_Hours|Reallocated_Sector_Ct'
    echo ""
done < $DISKDETECT
