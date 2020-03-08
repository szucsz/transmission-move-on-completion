#!/bin/bash

SCRIPT_DIR="$(dirname $0)"

[ -f $SCRIPT_DIR/auth.conf ] && source $SCRIPT_DIR/auth.conf

TRACKER_INFO="$(transmission-remote -ne -t $TR_TORRENT_ID -it)"

while IFS=: read -r TRACKER_PATTERN LOCATION; do
    [[ "$TRACKER_PATTERN" = "" ]] && continue
    [[ "$TRACKER_PATTERN" =~ ^#.*$ ]] && continue

    echo "$TRACKER_INFO" | grep -E 'Tracker [0-9]+:' | grep -q $TRACKER_PATTERN
    RC=$?
    if [[ $RC -eq 0 ]]; then
        [[ -d $LOCATION ]] || mkdir -p $LOCATION
        transmission-remote -ne -t $TR_TORRENT_ID --move $LOCATION
        RC=$?
        [[ $RC -eq 0 ]] && logger "on-completion: torrent id: $TR_TORRENT_ID has been moved to $LOCATION" || logger "on-completion: torrent id: $TR_TORRENT_ID error: $RC"
        break 
    fi
done < $SCRIPT_DIR/on-completion-dirs.conf

