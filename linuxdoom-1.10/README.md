# Compile Issues

1. Fix "initializer element is not constant" with `-std=c99`

If you see errors like this:
```
m_misc.c:257:48: error: initializer element is not constant
```

Then it probably means your compiler is using a C standard version that is too old.  It looks like non-constants in initializer lists may have been introduced in c99, so just add `-std=c99` to fix.


# First Patch

Instructions taken from http://geekchef.com/running-doom-under-linux/

Fixing errors and compiling

The first thing about Doom, is that its creator, id software, released the source code but not any of the data files to run it, called IWADs, which contain the images and sounds of the game. You must either have the commercial version of Doom, Doom II or Ultimate Doom, or the shareware version (a copy of the shareware IWAD is available here). Unzip it and put that file somewhere on your system. We’ll need to point to it later on.

Unzipping the file gives you two packages, the source code of DOOM and a separate sound server that Doom will embed at run time (apparrently, id licensed a copyrighted sound engine at the time, which is why there is no original DOS release: ‘A mistake’ says John Carmack in the README.TXT file.)

Unzip the source code and make the following changes:

```
In i_video:49, replace
#include <errnos.h>
with
#include <errno.h>

In i_sound.c:166 and i_video.c:669, delete all declarations of
extern int errno;
and include this file somewhere at the top of i_sound.c:
#include <errno.h>

In s_sound.c:367, replace
#ifndef SNDSRV
with
#ifndef SNDSERV

In the Makefile, add the -DSNDSERV define for compilation.

change d_main.c:587 from
doomuwad = malloc(strlen(doomwaddir)+1+8+1);
to
doomuwad = malloc(strlen(doomwaddir)+1+9+1);
```
This “off-by-one” error will generate a ASSERT error in malloc.c:3074 once the X display kicks in. The gdb debugger will tell you so, and yet we are very far from any video initialization at this moment. It took me a while to trap this.

Compile by simply calling ‘make’ at the command line. Everything should compile under 30 seconds. Don’t (?) worry about all the warnings you’ll see passing by. They shouldn’t affect the game at this point. Feel free to clean up the code if you like.
