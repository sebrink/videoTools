ffmpeg -i "$1" -i "$2" -c:v copy -map 0:v:0 -map 1:a:0 tmp.mp4
ffmpeg -i tmp.mp4 -ss 0 -to 30 -c copy $3
