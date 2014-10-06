#!/bin/bash
FROMADDR="root@wirehead.be"
TOADDR="jeffrey@wirehead.be"
CONTENT="$(cat <&0)"

# prevent sending empty mails
if [ "$CONTENT" == "" ]
then
	exit 0
fi

# header
cat <<End-of-message
MIME-Version: 1.0
From: $FROMADDR
To: $TOADDR
Subject: $1
Content-Type: text/html
<!DOCTYPE html>
<html>
<head>
<title>$1</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=900, initial-scale=1">
<meta content="telephone=no" name="format-detection">
<style type="text/css">
<!--
#fixcontent{font-family: "Courier New", Courier, monospace; white-space:pre-wrap;}
hr{color:#c00;background-color:#c00;height:1px;border:none;}
body{min-width:900px;}
--->
</style>
</head>
<body>
<h1>$1</h1>
<hr>
<div id="fixcontent">
End-of-message

echo "$CONTENT"

# footer
cat <<End-of-message
</div>
</body>
</html>
End-of-message
