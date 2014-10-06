#!/usr/bin/python
import subprocess
 
print "Content-type: text/text"
print 
output = subprocess.check_output(["./base-top.sh"])
print output
