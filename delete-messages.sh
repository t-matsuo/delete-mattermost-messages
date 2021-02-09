#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>

source common.sh

if [ "$1" = "-q" ]; then
    QUIET=y
fi

CHANNELS=`./get-blackhole-channel-id.sh`
if [ "$CHANNELS" = "" ]; then
    exit 0
fi

SQL='select ID,DisplayName from Channels Where DisplayName REGEXP "':[0-9]+[s,m,h,d,y]\$'";'
CHANNEL_ID=`EXEC_MYSQL "$SQL"` 

if [ "$CHANNEL_ID" = "" ]; then
    echo "info: No target ChannelID"
    exit 0
fi

log "--------- Target Channel IDs and Display Names ---------"
log "$CHANNEL_ID"
log "--------------------------------------------------------"
CHANNEL_ID=`echo -e "$CHANNEL_ID" | sed -e "s/	.*:/:/g"`

NOW=`./get-unix-time-ago.sh 0s`

# delete messages logically
for ID_TIME in $CHANNEL_ID; do
    ID=`echo $ID_TIME | cut -d ":" -f 1`
    AGO=`echo $ID_TIME | cut -d ":" -f 2`
    LIMIT=`./get-unix-time-ago.sh $AGO`
    if [ $? -ne 0 ]; then
        echo "error: cannot get unix time : $AGO"
        exit 1
    fi

    log "deleting ChannelID=$ID"
    SQL='update Posts set DeleteAt='\'$NOW\'',UpdateAt='\'$NOW\'' where ChannelID="'$ID'" and CreateAt < '$LIMIT' and DeleteAt = "0";'
    EXEC_MYSQL "$SQL"
done

# delete too old messages completely (AGO + 2Month)
for ID_TIME in $CHANNEL_ID; do
    ID=`echo $ID_TIME | cut -d ":" -f 1`
    AGO=`echo $ID_TIME | cut -d ":" -f 2`
    BASE=`date -R -d "2 month ago"`
    if [ $? -ne 0 ]; then
        echo "error: cannot get base date"
        exit 1
    fi
    LIMIT=`./get-unix-time-ago.sh $AGO "$BASE"`
    if [ $? -ne 0 ]; then
        echo "error: cannot get unix time : $AGO"
        exit 1
    fi

    log "deleting ChannelID=$ID completely"
    SQL='delete from Posts where ChannelID="'$ID'" and CreateAt < '$LIMIT';'
    EXEC_MYSQL "$SQL"
done

log "done"
exit 0
