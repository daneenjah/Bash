#!/bin/sh

#sensors | grep "Package id 0:" | tr -d '+' | awk '{print $4}' | sed 's/.0//g'

sensors | grep "Package id 0:" | tr -d '+' | awk '{print substr($4, 1, length($0)-52)}'
