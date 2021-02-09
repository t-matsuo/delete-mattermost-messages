#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>

# Usage: ./get-channel-id TeamName ChannelName

source common.sh

TEAM_NAME="$1"
CHANNEL_NAME="$2"
if [ "$TEAM_NAME" == "" ]; then
   echo "error: TeamName is not specified"
   exit 1
fi
if [ "$CHANNEL_NAME" == "" ]; then
   echo "error: ChannelName is not specified"
   exit 1
fi

TEAM_ID=`./get-team-id.sh $TEAM_NAME`
if [ $? -ne 0 ]; then
   echo "error: cannot get TeamID"
   exit 1
fi

SQL='select ID from Channels where Name="'$CHANNEL_NAME'" and TeamId="'$TEAM_ID'";'
CHANNEL_ID=`EXEC_MYSQL "$SQL"`

if [ "$CHANNEL_ID" = "" ]; then
    echo "error: cannot get ChannelID"
    exit 1
fi

echo $CHANNEL_ID
exit 0
