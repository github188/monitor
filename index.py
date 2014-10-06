#!/usr/bin/python
import subprocess
 
print "Content-type: text/html"
print

with open("header.txt", 'r') as fin:
    print fin.read()

print """<span style="padding-left:4px;">DilOS status</span></br></br>"""
print """<div id="refreshcontent">Gathering statistics... Please wait...</div>"""

print """
<script type="text/javascript">
$(document).ready(function() {$('#refreshcontent').load('cgi-top.py');})

var auto_refresh = setInterval(
function ()
{
$('#refreshcontent').load('cgi-top.py').fadeIn("slow");
}, 2000); // refresh every 2000 milliseconds
</script>
"""

with open("footer.txt", 'r') as fin:
    print fin.read()
