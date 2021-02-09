#!/bin/bash
# MATSUO Takatoshi <matsuo.tak@gmail.com>

export MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
export MYSQL_PORT=${MYSQL_PORT:-3306}
export MYSQL_DB=${MYSQL_DB:-mattermost_test}
export MYSQL_USER=${MYSQL_USER:-mmuser}
export MYSQL_PWD=${MYSQL_PASS:-mostest}
QUIET=n

function EXEC_MYSQL {
    mysql -u $MYSQL_USER -P $MYSQL_PORT -h $MYSQL_HOST -B -N --default-character-set=utf8 $MYSQL_DB -e "$1" | sed -e "s/[\r]\+//g"
}

function log {
    if [ "$QUIET" != "y" ]; then
        echo -e "$*"
    fi
}
