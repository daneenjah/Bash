#!/bin/bash
# A little script that will display current barometric pressure from Weather Display's
# clientraw outputs with arrows to indicate the pressure trend.
# I implemented the -> arrow for the rare posibility the pressures would be the same.
# This shouldn't happen often, and would likely indicate a break somewhere unless
# you indicate something closer to the current temperature (around 361 on line 17).
# Arrows are nerd font which must be installed to view properly.

# pull the files off the server
wget --quiet -O .clientraw2.txt http://192.168.0.47/weather/clientraw.txt
wget --quiet -O .clientrawhour2.txt http://192.168.0.47/weather/clientrawhour.txt

# clientraw: 7 is current pressure
# hourly: 302 is the oldest reported in hourly, 361 is newest
# picking something too new will result in inaccurate arrows (350 is 10 minutes)
clientraw=$(awk '{ print $7 * 0.029529980164712}' .clientraw2.txt)
clientrawhour=$(awk '{ print $350 * 0.029529980164712}' .clientrawhour2.txt)

# bash can't handle decimals, let bc do it and get a 0 or 1 response
bc=$(bc -l <<< "$clientrawhour >= $clientraw")
bceq=$(bc -l <<< "$clientrawhour == $clientraw")

# get the difference of the two
# We can use this in the up/down echos to how much it's changed.
#bcdif=$(bc -l <<< "$clientraw - $clientrawhour")

# up arrow for hourly temp not being greater than current
if [ $bc -eq 0 ] && [ $bceq -eq 0 ]
then
echo $clientraw 
fi

# down arrow for hourly temp being greater than current
if [ $bc -eq 1 ] && [ $bceq -eq 0 ]
then
echo $clientraw 
fi

# current and previous temp are the same ->
if [ $bceq -eq 1 ]
then
echo $clientraw 
fi
