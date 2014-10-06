#!/usr/bin/python
import subprocess
 
print "Content-type: text/html"
print

with open("header.txt", 'r') as fin:
    print fin.read()

print """<span style="padding-left:4px;">Disk Probe Status</span>"""
print """<div id="maincontent">"""

output = subprocess.check_output(["./base-probe.sh"])
print output

print "</div>"
with open("footer.txt", 'r') as fin:
    print fin.read()
