======
Movier
======

Movier is a simple utility to copy (hardlink) your movie files to your media directory with proper file names and subtitle encoding (converts to UTF-8 to get the subtitles render properly in Plex_)

.. _Plex: https://plex.tv/

The basic idea is that this tool should help you clean up your media from some download/rip/backup dir to a proper place following the namig convetions recommended by Plex team:

    ``media directory/movie name/movie name( - part#).ext``

It tries to detect your subtitle encoding and if it's not UTF, it will try to convert the file to UTF-8. It should come with reasonable defaults, but it's also fairly configurable via commandline options - see Usage_ bellow.

For extra comfort, you can setup default settings that suit you. Configuration_ section explains how to do that. Once done, in the majority of cases you'll just need to run this command with one or two parameters.

Quick usage
===========

.. code-block:: bash

    $ movier "Movie name" /path/to/movie/source

Where:
    *movie name* 
        is the name of the movie, in most cases you neet to provide it in quotes to avoid bash expansion or if it consists  of multiple words.
    *source path*
        is a path to the source movie file/directory - you can even omit this if the source is current directory!

I guess that's as easy as it gets..

Movier never alters any of the source files, it just creates hardlink pointing to the original location and in case it needs to change subtitle encoding it will do so by reading the source and writing the new file to target directory. By default it won't even continue if the target directory exists to prevent some accidental damage to existing files. This all makes any mistakes trivial - in most cases you can just wipe newly created directory and try again.

Usage
=====

:: 

    $ ./movier --help
    usage: movier [-h] [-c CONFIG_FILE] [-d] [-i] [-m MEDIA] [-e EXTENSIONS]
                [-s SUB_EXTENSIONS] [-l SUB_LANGUAGE] [-f FALLBACK_ENCODING]
                name [source]

    Copy movies to your library.

    positional arguments:
    name                  Name of the movie
    source                Where to copy the movie from (file or directory with
                            movie) Defaults to current directory.

    optional arguments:
    -h, --help            show this help message and exit
    -c CONFIG_FILE, --config-file CONFIG_FILE
                            Config with default settings to load.
    -d, --dry-run         Just print the steps, do not actually permform them
    -i, --ignore-existing
                            Ignore existing target directory.
    -m MEDIA, --media MEDIA
                            Target directory with your media library
    -e EXTENSIONS, --extensions EXTENSIONS
                            Comma separated list of movie extensions.
    -s SUB_EXTENSIONS, --sub-extensions SUB_EXTENSIONS
                            Comma separated list of subtitle extensions.
    -l SUB_LANGUAGE, --sub-language SUB_LANGUAGE
                            Language code of the subtitles. If specified it adds
                            the code to the file name before the extension.
    -f FALLBACK_ENCODING, --fallback-encoding FALLBACK_ENCODING
                            Fallback encoding of subtitle file if autodetection
                            falls.

Configuration
=============

Movier tries to read defaults from following places:
 * /etc/movier/movier.cfg
 * ~/.movier.cfg
 * any file provided with the `-c` option

All files are processed in the above order, if multiple files contain the same setting, the last file read with that setting takes precedence. That means you can put system-wide defaults in the `/etc/movier` directory, have per-user defaults in their home directory and still override some defaults with file provided at commandline.

The configuration is in `ini` format. All settings are read from the *movier* section. The individual settings have the same name as long version of the commandline options. If the option contains multiple words, separate them with undescore instead of hypen.

Example of such configuration:

.. code-block:: ini

    [movier]
    sub_language=cz
    media=/path/to/my/moview
    fallback_encoding=WINDOWS-1251


Installation
============

From Git:
---------

.. code-block:: bash

    git clone https://github.com/mprasil/movier.git
    cd movier
    python setup.py install

Dependencies
============

Movier only depends on Chardet_ for subtitle character encoding detection.

.. _Chardet: https://github.com/chardet/chardet




