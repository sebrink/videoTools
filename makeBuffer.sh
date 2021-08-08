#!/bin/bash
# written by sandw1ch
# $1 name of the video
# $2 output name of your buffer
# $3 name of the logo to pull
# $4 music file

time=`ffprobe -i $1 -show_format -loglevel quiet|grep 'duration=' | cut -d'=' -f2`
test=`echo $time/1|bc`
music=$(echo "(`ffprobe -i $3 -show_format -loglevel quiet| grep 'duration=' | cut -d'=' -f2`)/1"|bc)
#echo "Time: $time"
#echo "TestL $test"
#echo "Mus $music"
if [ $test -gt 1800 ];then
        loops=`echo "((3600-$time)/$music)-1"|bc`
        clip=`echo "((3600-$time)%$music)/1"|bc`
else
        loops=`echo "((1800-$time)/$music)-1"|bc`
        clip=`echo "((1800-$time)%$music)/1"|bc`
fi

# Loop file X amount of times
ffmpeg -i $3 -c copy tmp.mkv -y
ffmpeg -stream_loop $loops -i tmp.mkv -c copy $2 -y
rm tmp.mkv

# Add music
#ffmpeg -i $2 -i $5 -filter_complex " [1:0] apad " -c:v copy -shortest test.mp4
#ffmpeg -i blob.mp4 -i $5 -filter_complex " [1:0] apad " -c:v copy -shortest tmp4.mp4

# Make the final clip
ffmpeg -i $3 -ss 0 -to $clip -c copy $4 -y
