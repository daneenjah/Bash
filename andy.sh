#!/bin/bash
 # We'll ping Andy's .177 IP address, if it's down we'll echo a thumbs up.
 # If it pings, we'll echo a thumbs down. This will let us know which network
 # he's on based on his IP.

ping -c 1 192.168.0.177 &> /dev/null

if [ $? -ne 0 ]; then
    echo ""
else
    echo ""
fi
