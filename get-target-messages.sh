#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>

source common.sh

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

log
log "------------------ Target Messages ---------------------"

for ID_SEC in $CHANNEL_ID; do
    ID=`echo $ID_SEC | cut -d ":" -f 1`
    AGO=`echo $ID_SEC | cut -d ":" -f 2`
    LIMIT=`./get-unix-time-ago.sh $AGO`
    if [ $? -ne 0 ]; then
        echo "error: cannot get unitx time : $AGO"
    fi

    SQL='select ChannelId,Message from Posts where ChannelID="'$ID'" and CreateAt < '$LIMIT' and DeleteAt = 0;'
    EXEC_MYSQL "$SQL"
    echo
done
log "--------------------------------------------------------"

exit 0
