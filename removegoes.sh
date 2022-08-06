#!/bin/bash
find /home/pi/goes* -type d -mtime +10 -exec rm -rf {} \;
