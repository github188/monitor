#!/usr/bin/python
import subprocess
 
print "Content-type: text/html"
print

with open("header.txt", 'r') as fin:
    print fin.read()

print """<span style="padding-left:4px;">S.M.A.R.T Status</span>"""
print """<div id="refreshcontent">Gathering statistics... Please Wait...</div>"""

print """
<script type="text/javascript">
$(document).ready(function() {$('#refreshcontent').load('cgi-smart.py');})
</script>
"""

with open("footer.txt", 'r') as fin:
    print fin.read()
