#!/usr/bin/python
import subprocess
 
print "Content-type: text/text"
print 
output = subprocess.check_output(["dmesg"])
print output
