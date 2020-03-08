#!/bin/bash

SCRIPT_DIR="$(dirname $0)"

[ -f $SCRIPT_DIR/auth.conf ] && source $SCRIPT_DIR/auth.conf

while IFS=" " read -r TORRENT_ID PERCENT SIZE SIZE_UNIT ETA ETA_UNIT REMAINING; do
    if [[ $ETA == Done ]]; then
        export TR_TORRENT_ID=${TORRENT_ID//\*}
        $SCRIPT_DIR/on-completion.sh
        echo "moved torrent id: $TR_TORRENT_ID ETA: $ETA"
    else
        echo "skipping torrent id: $TR_TORRENT_ID Done: $PERCENT"
    fi
done < <(transmission-remote -ne -l)

