#!/bin/bash

GUSERNAME="your_gmail_username"
GPASS="your_gmail_pass"

GOOGLE_ATOM="$(wget --secure-protocol=TLSv1 --timeout=3 -t 1 -q -O - \
https://${GUSERNAME}:${GPASS}@mail.google.com/mail/feed/atom \
--http-user="$1" --http-password="$2" --no-check-certificate)"
EXIT_CODE="$?"
if [[ $EXIT_CODE != 0 ]];then
	echo Error!
	exit 1;
fi
MAIL_COUNT="$(echo "$GOOGLE_ATOM"|grep 'fullcount'|sed -e 's/.*<fullcount>\(.*\)<\/fullcount>.*/\1/' 2>/dev/null)"
if [ -z "$MAIL_COUNT" ]; then
	echo "0 mesaje noi"
elif [ "$MAIL_COUNT" == "1" ]; then
	echo "1 mesaj nou"
else
	echo "$MAIL_COUNT mesaje noi"
fi
