#!/usr/bin/python
import subprocess
 
print "Content-type: text/html"
print

with open("header.txt", 'r') as fin:
    print fin.read()

print """<span style="padding-left:4px;">IOstat Error Report (s/w h/w trn tot)</span></br></br>"""
print """<div id="refreshcontent">Gathering statistics... Please Wait...</div>"""

print """
<script type="text/javascript">
$(document).ready(function() {$('#refreshcontent').load('cgi-iostat.py');})

var auto_refresh = setInterval(
function ()
{
$('#refreshcontent').load('cgi-iostat.py');
}, 5000); // refresh every 5000 milliseconds
</script>
"""

with open("footer.txt", 'r') as fin:
    print fin.read()
