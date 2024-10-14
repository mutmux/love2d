# love2d
experiments with LÖVE

##### /audio_visualisation
poor attempt at audio visualisation. it's bad mainly because I wasn't entirely sure what I was doing at the time. I'd almost certainly do a better job at this point, but I'm not currently interested in love2d at this time. to try it out, drop any FLAC file in this directory and call it `track.flac`. use the left and right arrow keys to seek through the track. press space to pause and play.

##### /hello
the standard "hello world", in the top corner of the window.

##### /move_rect
lets you move a little rectangle around the screen with WASD keys. you can left click to have a red line appear from the centre of the rectangle to your mouse cursor. keep the mouse button held to keep the line drawn. you can hold left shift to boost.

##### /move_rect_enemy
expands on `/move_rect` and lets you hover your cursor over cube enemies to destroy them. 5 enemies are spawned by default. you can spawn more enemies at any time by right clicking.

##### /window_grower
on each frame, the window grows by 10 pixels in width and height. exceptionally laggy on certain window managers and shells, really fast on others.

##### /window_mover
lets you move a window across the screen with WASD keys. you can hold left shift to boost. movement of the window is confined to the screen the window starts up on (your default monitor).
