#!/bin/bash

SCRIPT_DIR="$(dirname $0)"

[ -f $SCRIPT_DIR/auth.conf ] && source $SCRIPT_DIR/auth.conf

while IFS=" " read -r TORRENT_ID PERCENT SIZE SIZE_UNIT STATUS REMAINING; do
    if [[ $STATUS == Done ]]; then
        export TR_TORRENT_ID=${TORRENT_ID//\*}
        transmission-remote -ne -t $TR_TORRENT_ID -i | grep 'Id:\|Name\|Location'
        transmission-remote -ne -t $TR_TORRENT_ID -it | grep -E 'Tracker [0-9]+:'
        echo '----------'
    fi
done < <(transmission-remote -ne -l)

