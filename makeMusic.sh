#!/bin/bash
# written by sandw1ch
# $1 is the video file
# $2 is the audio file
# $3 is your new file with the audio on it clipped down to 30 seconds
ffmpeg -i "$1" -i "$2" -c:v copy -map 0:v:0 -map 1:a:0 tmp.mp4
ffmpeg -i tmp.mp4 -ss 0 -to 30 -c copy $3
rm tmp.mp4
