#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>

# Usage: ./get-team-id TeamName

source common.sh

TEAM_NAME="$1"
if [ "$TEAM_NAME" == "" ]; then
   echo "error: TeamName is not specified"
   exit 1
fi

SQL='select ID from Teams where Name="'$TEAM_NAME'";'
TEAM_ID=`EXEC_MYSQL "$SQL"`

if [ "$TEAM_ID" = "" ]; then
    exit 1
fi

echo "$TEAM_ID"
exit 0
