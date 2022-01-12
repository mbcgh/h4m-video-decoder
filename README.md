# HVQM4 1.3/1.5 (*.h4m) Video Decoder

This repro acts as a fork of the work previously done by Tilka who basically figured this all out. Unfortunatly, his version of the program comes with very little documentation or any sort of explanation on usage. A small bug in the original program prevents it from creating the folder it needs to dump the frames as well.
This program only deals with video/frames. For audio, use the seperate/pre-existing audio dumper
[Original audio dumper](https://hcs64.com/mboard/forumlong.php?showthread=20147).

This README will act as a basic guide for if you want to get things up and running quickly.

##Prerequisites
00. You'll need some kind of Linux enviroment for this project. Any Ubuntu based distro should work just fine (you can run this within a VM if you're a Windows/Mac sucker)
01. This guide assumes you are the root user.

##Compiling
01. Open Terminal, install ``clang`` with ```sudo apt install clang```
02. Within Terminal, change directory (cd) into your "hvqm4_video_decode"
03. Compile! ou can either use the "make.sh" file or run the following command
``clang -march=native -O2 -funroll-loops -Wall -Wextra h4m_audio_decode.c -o h4m -DNATIVE=1``
04. You should be left with a "h4m" file within the same folder after the compile has been completed.

##Decoding / Usage
01. Place whatever .h4m file you wish to decode into the folder we mentioned previously (hvqm4_video_decode).
02. Run the command ``./h4m party003.h4m b.wav`` while still in the "hvqm4_video_decode" directory.
03. Done! This will output the individual frames into a folder it creates called "output". This folder is within the "hvqm4_video_decode" directory.

##Frames -> Video (Optional)
There are a few ways you can do this, but this method can be done through command line and without much hassle. It'll result in a lossless .avi file.

01. Install ffmpeg
02. Change directory (cd) into the "output" folder.
03. Run ```ffmpeg -pattern_type glob -framerate 29.97 -i "video_rgb_*.ppm" -c:v ffvhuff video.avi```

**Note that you may end up with more frames than the file naming scheme will "allow" for. By default, it's only a 4 digit maximum. If you exceed 4 digits (or 9999) frames, it'll mess with the frame order within the dir and not work with the above ffmpeg command.**
To fix this;
01. Open ``h4m_audio_decode.c`` file
02. Search for ``sprintf(name, "output/video_rgb_%04u.ppm", gop_start + disp_id);``
03. Change ``%04u`` to ``%05u``
04. Save
05. Recompile

## Credits
The majority and foundation of this code was written by Tilka. His code is based on the HVQM4 1.3/1.5 audio decoder by hcs.