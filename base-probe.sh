#!/bin/bash
SAS2IRCU="/usr/sbin/sas2ircu"
TEMPFILE="/tmp/sasdisplay.txt"
TEMPDFILE="/tmp/diskdetect.txt"
DISKDETECT="./diskdetect.txt"
cat /dev/null > $TEMPFILE
cat /dev/null > $TEMPDFILE
cat /dev/null > $DISKDETECT
CONTROLLERS=$(sudo $SAS2IRCU list | awk 'NR > 9 { print l } {l=$0}')

while read -r line; do
	CURCTRL=$(echo $line | awk '{print $1}')
	sudo $SAS2IRCU $CURCTRL display >> $TEMPFILE
done <<< "$CONTROLLERS"

#save showalldisks
cat $TEMPFILE | nawk 'c&&c--;/Device is a Hard disk/{c=12}' | awk -F\: '{print $2}' | sed 's/^[[:space:]]*//; s/;[[:space:]]*/;/g' | paste - - - - - - - - - - - - > $TEMPDFILE

#  Enclosure #                             : 1
#  Slot #                                  : 7
#  SAS Address                             : 4433221-1-0400-0000
#  State                                   : Ready (RDY)
#  Size (in MB)/(in sectors)               : 2861588/5860533167
#  Manufacturer                            : ATA     
#  Model Number                            : ST3000VN000-1H41
#  Firmware Revision                       : SC43
#  Serial No                               : W300KA30
#  GUID                                    : 5000c50069d9aa78
#  Protocol                                : SATA
#  Drive Type                              : SATA_HDD
while read line
do
	DISK=$(echo $line | tr '[:lower:]' '[:upper:]' | awk '{print $11"d0"}')
	RDSK=$(cd /dev/rdsk && ls *$DISK)
	echo -e "$line\t$RDSK" >> $DISKDETECT
done < $TEMPDFILE
cat $DISKDETECT | awk '{ print "Found disk: " $7" "$8" identifier: "$14" at enclosure "$1", slot "$2}'
