#!/usr/bin/python
import subprocess
 
print "Content-type: text/html"
print

with open("header.txt", 'r') as fin:
    print fin.read()

print """<span style="padding-left:4px;">ZFS Summary</span>"""
print """<div id="maincontent">"""

output = subprocess.check_output(["zfs", "list", "-t", "all"])
print output

with open("footer.txt", 'r') as fin:
    print fin.read()
