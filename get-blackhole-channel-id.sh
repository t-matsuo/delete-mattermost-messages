#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>

source common.sh

SQL='select ID,DisplayName from Channels Where DisplayName REGEXP "':[0-9]+[s,m,h,d,y]\$'";'
CHANNEL_ID=`EXEC_MYSQL "$SQL"`

if [ "$CHANNEL_ID" = "" ]; then
    echo "error: cannot get ChannelID"
    exit 1
fi

echo -e "$CHANNEL_ID" | sed -e "s/	.*:/ /g"
exit 0
