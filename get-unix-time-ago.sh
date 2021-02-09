#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>
#
# Usage: ./get-unix-time-min-ago.sh 3s : 3 secs ago
#        ./get-unix-time-min-ago.sh 3m : 3 miniutes ago
#        ./get-unix-time-min-ago.sh 3h : 3 hours ago
#        ./get-unix-time-min-ago.sh 3d : 3 days ago
#        ./get-unix-time-min-ago.sh 3y : 3 years ago
# Usage: with base date
#        ./get-unix-time-min-ago.sh 3d 20200506 : 2020/05/06 3 days ago -> 2020/5/3

AGO="$1"
BASE="$2"

if [ "$AGO" == "" ]; then
    echo "error: Time is not specified"
    exit 1
fi

echo $AGO | grep -q '^[0-9]\+[s,m,h,d,y]$'
if [ $? -ne 0 ]; then
    echo "error: $AGO is invalid"
    exit 1
fi

if [ "$BASE" != "" ]; then
    date -d "$2" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "error: $BASE is invalid"
        exit 1
    fi
fi

UTIME=0
if echo "$AGO" | grep -q "s$"; then
    NUM=`echo "$AGO" | sed -e "s/s//g"`
    UTIME=`date -d "$BASE $NUM sec ago" +%s`
    # UTIME=`date -d "$BASE $NUM sec ago"`
elif echo "$AGO" | grep -q "m$"; then
    NUM=`echo "$AGO" | sed -e "s/m//g"`
    UTIME=`date -d "$BASE $NUM minute ago" +%s`
    # UTIME=`date -d "$BASE $NUM minute ago"`
elif echo "$AGO" | grep -q "h$"; then
    NUM=`echo "$AGO" | sed -e "s/h//g"`
    UTIME=`date -d "$BASE $NUM hour ago" +%s`
    # UTIME=`date -d "$BASE $NUM hour ago"`
elif echo "$AGO" | grep -q "d$"; then
    NUM=`echo "$AGO" | sed -e "s/d//g"`
    UTIME=`date -d "$BASE $NUM day ago" +%s`
    # UTIME=`date -d "$BASE $NUM day ago"`
elif echo "$AGO" | grep -q "y$"; then
    NUM=`echo "$AGO" | sed -e "s/y//g"`
    UTIME=`date -d "$BASE $NUM year ago" +%s`
    # UTIME=`date -d "$BASE $NUM year ago"`
else
    echo "BUG: Specified time is $AGO"
fi

echo ${UTIME}000
