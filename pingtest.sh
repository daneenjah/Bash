#!/bin/bash
 # We'll ping for four counts and echo the average
 
ping -c 4 google.com -I eno2 | tail -1| awk '{print $4}' | cut -d '/' -f 2
