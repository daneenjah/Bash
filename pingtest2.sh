#!/bin/bash
 # We'll ping for four counts and echo the average

ping -c 4 crius.feralhosting.com -I eno2 | tail -1| awk '{print $4}' | cut -d '/' -f 2
