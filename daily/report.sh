#!/usr/bin/env bash

awk 'BEGIN{print "{| class=\"wikitable\" style=\"margin:auto\""}NR ==1 {printf "! %s" ,$1;for (i=2;i<=9;i++){printf "!!%s ", $i;}printf("\n")}NR>1 {print "|-"; printf "| %d", $1;for(i=2;i<=9;i++){if(i==4){printf "||%.2f", $i;}else{printf "||%d ", $i;}}printf("\n")} END{print "|}"}' dailyf > rep
cat rep
tail -n 1 renderedf | sed 's/,//g'|awk '{printf "%04d %s/%s/%d EARNED(%s %s) INV:%d(%.2f%) \n", $1 - int($1/10000)*10000,$2,$9, $5,$7,$8,$11, $12+100;}'
# $12 per cent, 
