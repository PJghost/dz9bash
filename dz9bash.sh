#!/bin/bash

starttime=$(awk '{ print $4 }' access.log |head -n 1|sed -e 's/\[//g')
endtime=$(awk '{ print $4 }' access.log |tail -n 1|sed -e 's/\[//g')
echo -e "Log begins at $starttime and till $endtime"

IP=$(awk '{ print $1 }' access.log |sort | uniq -c |sort -rn | awk '{ if ($1 >=10) { print "Querys: " $1, "IP: " $2} }')
echo -e "\nIP adresses:\n$IP"
adress=$(awk '($9 ~ /200/)' access.log | awk '{print $11}' |sort | uniq -c |sort -rn | awk '{ if ( $1 >=10 ) { print "Querys: " $1, "URL: " $2 } }')
echo -e "\nRequested URLS:\n$adress"
errors=$(cat access.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -rn)
echo -e "\nErrors and codes:\n$errors"
