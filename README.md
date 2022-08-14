# AnsiLove/C without dependencies

This repository contains a simple build environment that allows building
the C stand-alone executable for the [AnsiLove](https://github.com/ansilove/ansilove)
ANSI/ASCII-art renderer without major external dependencies -- namely, the GD library.

## Why?

The main reason for this project's existence is that I wanted to have a
stand-alone ANSI/ASCII renderer for [CompoKit](https://github.com/kajott/CompoKit),
which is a Windows-based environment. White AnsiLove/C fits the bill perfectly in
terms of features, it's a bit cumbersome to deploy for two reasons:
- Despite AnsiLove's claims of, I quote,
  "high portability to all major operating systems",
  it doesn't build on anything that's not fully POSIX compliant.
- The only third-party library dependency of AnsiLove, namely the
  [GD](https://libgd.github.io) graphics library,
  has a whole lot of dependencies itself.

## How?

This project does two things. First, it:
- builds AnsiLove using a simplified Makefile-based flow,
- replaces the few functions of GD that AnsiLove uses by very simple reimplementations or just stubs,
- uses [lodepng](https://github.com/lvandeve/lodepng) to encode PNG files.

That gets rid of the GD dependency.
To make all of that work on Win32 systems, another layer of hacks is needed.
(Yes, the word "hacks" is deliberate; I won't sugar-coat this.)
I tried multiple approaches to this, all the while trying to **not** modify
any AnsiLove code and only build wrappers and stubs:
- ~~Build everything with MSVC, create stubs as we go.~~
  No way, MSVC is just too far away from the level of POSIX compliance that
  the AnsiLove code requires.
- ~~Build on Windows using MinGW.~~ That went a bit further, but still there
  was too many stuff that's just missing.
- Cross-compile from Linux using the MinGW packages that are shipped by Ubuntu
  (`mingw-w64` + `mingw-w64-x86-64-dev`); building on Windows itself is then
  done using WSL. This is what ultimately worked without too much hair-pulling.

## Features / Caveats / Known Issues

- (Win32) single statically-linked executable
- (Linux) executable with only standard `libc` dependencies
- can render ANSI files to PNG as usual
- *but:* scaling options (`-r`/`-R` and `-d`) do **not** work (empty output image)
  - This could be fixed in a later version that implements `gdImageCopyResized` and `gdImageCopyResampled`, if there's a need for these features.
- even in transparent mode (`-m transparent`), the background is opaque black
- (Win32) MinGW's option parser insists on having options first,
  and positional arguments at the end of the command line. This means, for example,
  that you **have** to specify the output file name before the input; in other words,
  ~~`ansilove -S input.ans -o rendered.png`~~
  does _not_ have the desired effect, but
  `ansilove -S -o rendered.png input.ans` does.
- tested on Windows 10 and Ubuntu 20.04 with various ANSI files,
  including [ridiculously large](http://blocktronics.org/blocktronics-wtf4-megajoint-ans/) ones

## Build Instructions

First, make sure that you clone this repository recursively
(`git clone --recursive https://github.com/...`) or initialize submodules
afterwards:

    git submodule init
    git submodule update

On Linux (and, ostensibly, other similar systems that have a `make` and `cc` that's reasonably GNU-compatible), just run `make` (with your personal preference of how much `-j` you want) to get an `ansilove-`_`your_OS_name`_ binary. To install that
in `/usr/local/bin/ansilove`, use

    sudo make install

To create a Windows binary, install the MinGW-W64 cross-build tools and run

    make CROSS=1

to get `ansilove.exe`.

## Usage Instructions

These are exactly the same as for standard upstream [AnsiLove](https://github.com/ansilove/ansilove),
with the aforementioned exception that you shouldn't touch the `-r`, `-R` and `-d` options even though they're still there.

Since the built-in help (`-h`) is notoriously useless, you should always keep
[the upstream command-line option documentation](https://github.com/ansilove/ansilove#Options) under your pillow.
