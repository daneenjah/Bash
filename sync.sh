#!/bin/bash

login=
pass=
host=
remote_dir=
local_dir="/mnt/public/Videos/TV\ Shows/"


trap "rm -f /tmp/synctorrent.lock" SIGINT SIGTERM

if [ -e /tmp/synctorrent.lock ]
then
  echo "Synctorrent is running already."
  exit 1
else

  touch /tmp/synctorrent.lock

  lftp -u $login,$pass $host << EOF
  set sftp:auto-confirm yes
  set ftp:ssl-allow no
  set mirror:use-pget-n 1
  set net:limit-total-rate 150000:0
  mirror -p -s --ignore-time -P1 --log=/tmp/synctorrents.log $remote_dir $local_dir
  quit
EOF

  rm -f /tmp/synctorrent.lock
  exit 0

fi
