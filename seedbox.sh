#!/bin/bash
#login information for your seedbox, no quotes
login=
#password information for your seedbox, no quotes
pass=
#host info for your seedbox. include full URL standard format is sftp://ftp.servername.com
host=
#remote location where your finished downloads are on your seedbox
remote_dir=
#local directory where you are storing your downloads for further processing
local_dir="/mnt/public/Videos/TV\ Shows/"

#the next few lines creates a temp file and locks it down so only one instance of this script runs at a time, then mirrors the remote directory (one-way) to the local computer.
trap "rm -f /tmp/synctorrent.lock" SIGINT SIGTERM
if [ -e /tmp/synctorrent.lock ]
then
  echo "Synctorrent is running already."
  exit 1
else
  touch /tmp/synctorrent.lock
  lftp -u $login,$pass $host << EOF
  set ftp:ssl-allow no
  set mirror:use-pget-n 5
  set net:limit-total-rate 100040:0
  mirror -c -p --log=/tmp/synctorrents.log $remote_dir $local_dir
  quit
EOF
  rm -f /tmp/synctorrent.lock
  trap - SIGINT SIGTERM
  exit 0
fi
