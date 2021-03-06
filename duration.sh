#!/bin/bash
# written by sandw1ch
# $1 = name of video to get length from.
time=`ffprobe -i $1 -show_format -loglevel quiet|grep 'duration=' | cut -d'=' -f2`
echo "[+] This video is $time seconds long."
echo ""
echo "[+] For 60 minutes:"
echo "[+] Loops: `echo "((3600-$time)/30)-1"|bc` times."
echo "[+] Clip: `echo "(3600-$time)%30/1"|bc`seconds."
echo "[+] Total Buffer Needed: `echo "(3600-$time)"|bc` seconds."
echo ""
echo "[+] For 30 minutes:"
echo "[+] Loops: `echo "((1800-$time)/30)-1"|bc` times."
echo "[+] Clip: `echo "(1800-$time)%30"|bc`seconds."
echo "[+] Total Buffer Needed: `echo "(1800-$time)"|bc` seconds."
