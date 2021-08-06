# $1 name of the video
# $2 output name of your buffer
# $3 name of the logo to pull

time=`ffprobe -i $1 -show_format -loglevel quiet|grep 'duration=' | cut -d'=' -f2`
test=`echo $time/1|bc`
if [ $test -gt 1800 ];then
	loops=`echo "((3600-$time)/30)-1"|bc`
	clip=`echo "((3600-$time)%30)/1"|bc`
	echo 60
else
	loops=`echo "((1800-$time)/30)-1"|bc`
	clip=`echo "((1800-$time)%30)/1"|bc`
	echo 30
fi

# Make the first clip
ffmpeg -i $3 -ss 0 -to $clip -c copy tmp.mp4 -y

# Loop file X amount of times
ffmpeg -i $3 -c copy tmp.mkv -y
ffmpeg -stream_loop $loops -i tmp.mkv -c copy video2.mp4 -y
rm tmp.mkv

# Concat files
ffmpeg -i video2.mp4 -i tmp.mp4 -filter_complex concat=n=2:v=1:a=0 $2 -y
rm tmp.mp4
rm video2.mp4
