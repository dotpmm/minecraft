#!/bin/bash

# Config
RCON_HOST=127.0.0.1
RCON_PORT=25575
RCON_PASS="pesumc#231#"
VM_NAME="mineserver"
ZONE="asia-south1-c"

# Run RCON "list" command
OUTPUT=$(mcrcon -H $RCON_HOST -P $RCON_PORT -p $RCON_PASS "list")

# Extract number of online players
PLAYERS=$(echo $OUTPUT | grep -oP '\d+(?= of)')

if [ "$PLAYERS" -eq 0 ]; then
    echo "No players online. Stopping VM..."
    gcloud compute instances stop $VM_NAME --zone=$ZONE
else
    echo "$PLAYERS players online. Server stays up."
fi
