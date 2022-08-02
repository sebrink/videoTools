# videoTools
ffmpeg go brrr (just reviewed this in 2022, and pretty sure I was losing my mind when i wrote this)

### duration.sh
- Given a single media file, you can see the duration and how long you have to make a clip for (in 30 second intervals).
- This just shows 30 and 60 minutes clip times, could add more functionality

### makeBuffer.sh
- Given a media file and a 30 second file, generates a buffer file that pads the video to either 30 minutes or 60 minutes. Other things _*will*_ break.
- Fails on 0 second clips
- File names must be 00_movie.mp4 (only underscores, not dashes)

### makeBuffer0.sh
- Rather than being smart, I made a second file with things commented out if the buffer needs a 0 second clip. I will probably remove this and make a conditional for `makeBuffer.sh` instead.
- File names must be 00_movie.mp4 (only underscores, not dashes)

### makeMusic.sh
- Given a 30 second media file and a mp3 file, sync the audio to the media file. The new video is then cut back down to 30 seconds again. 
- There are probably ways this breaks

### newScript.sh (need to make it, these are instructions
Step 1: loop file to greater than song length

##### Loop file X amount of times. 
ffmpeg -i grid.mp4 -c copy video.mkv
duration 0x.flac
ffmpeg -stream_loop 6 -i video.mkv -c copy input.mp4
rm video.mkv

Step 2: append song with shortest

##### Give mp4 and .flac to get output mp4
ffmpeg -i input.mp4 -i input.flac -filter_complex " [1:0] apad " -c:v copy -shortest output.mp4

Step 3: Clip to original song length
ffmpeg -i video.mp4 -ss 0 -to 164 -c copy tmp.mp4
