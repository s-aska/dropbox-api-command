[![Build Status](https://travis-ci.org/s-aska/dropbox-api-command.png?branch=master)](https://travis-ci.org/s-aska/dropbox-api-command)
# NAME

App::dropboxapi - command line interface to access Dropbox API

# SYNOPSIS

    dropbox-api put /tmp/foo.txt dropbox:/Public/

Run `dropbox-api help` for more options.

# DESCRIPTION

dropbox-api is a command line interface to access Dropbox API.

has many sub-commands ... ls, find, sync, cp, mv, rm, mkdir, get, put, uid

# Sub Commands

## help

disp help.

- syntax

    dropbox-api help \[<command>\]

### Example

    > dropbox-api help
    Usage: dropbox-api <command> [args] [options]

    Available commands:
        setup get access_key and access_secret
        ls    list directory contents
        find  walk a file hierarchy
        cp    copy file or directory
        mv    move file or directory
        mkdir make directory (Create intermediate directories as required)
        rm    remove file or directory (Attempt to remove the file hierarchy rooted in each file argument)
        put   upload file
        get   download file
        sync  sync directory (local => dropbox or dropbox => local)
        uid   get accound uid

    See 'dropbox-api help <command>' for more information on a specific command.

### Example ( command help )

    > dropbox-api help ls
    Name
        dropbox-api-ls - list directory contents

    SYNOPSIS
        dropbox-api ls <dropbox_path> [options]

    Example
        dropbox-api ls Public
        dropbox-api ls Public -h
        dropbox-api ls Public -p "%d\t%s\t%TY/%Tm/%Td %TH:%TM:%TS\t%p\n"

    Options
        -h print sizes in human readable format (e.g., 1K 234M 2G)
        -p print format.
            %d ... is_dir ( d: dir, -: file )
            %p ... path
            %b ... bytes
            %s ... size (e.g., 1K 234M 2G)
            %i ... icon
            %e ... thumb_exists
            %M ... mime_type
            %t ... modified time
            %r ... revision
            %Tk ... DateTime 'strftime' function

## ls

file list view.

- alias

    list

- syntax

    dropbox-api ls <dropbox\_path>

### Example

    > dropbox-api list /product
    d        - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
    -   294557 Sun, 26 Dec 2010 21:55:59 +0000 /product/ex.zip

### human readable option ( -h )

print sizes in human readable format (e.g., 1K 234M 2G)

    > dropbox-api ls /product -h
    d        - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
    -  287.7KB Sun, 26 Dec 2010 21:55:59 +0000 /product/ex.zip

### printf option ( -p )

print format.

    > dropbox-api ls /product -p "%d\t%s\t%TY/%Tm/%Td %TH:%TM:%TS\t%p\n"
    d       -       2011/02/24 06:58:00     /product/chrome-extentions
    -       287.7KB 2010/12/26 21:55:59     /product/ex.zip

        %d ... is_dir ( d: dir, -: file )
        %p ... path
        %b ... bytes
        %s ... size (e.g., 1K 234M 2G)
        %i ... icon
        %e ... thumb_exists
        %M ... mime_type
        %t ... modified time
        %r ... revision

        %Tk ... DateTime 'strftime' function
                <http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime_Patterns>

## find

recursive file list view.

- syntax

    dropbox-api find <dropbox\_path> \[options\]

### Example

    > dropbox-api find /product/google-tasks-checker-plus
    /product/chrome-extentions/google-tasks-checker-plus/README.md
    /product/chrome-extentions/google-tasks-checker-plus/src
    /product/chrome-extentions/google-tasks-checker-plus/src/background.html
    /product/chrome-extentions/google-tasks-checker-plus/src/external.png
    /product/chrome-extentions/google-tasks-checker-plus/src/icon-32.png
    /product/chrome-extentions/google-tasks-checker-plus/src/icon-128.png
    /product/chrome-extentions/google-tasks-checker-plus/src/icon.gif
    /product/chrome-extentions/google-tasks-checker-plus/src/jquery-1.4.2.min.js
    /product/chrome-extentions/google-tasks-checker-plus/src/main.js
    /product/chrome-extentions/google-tasks-checker-plus/src/manifest.json
    /product/chrome-extentions/google-tasks-checker-plus/src/options.html
    /product/chrome-extentions/google-tasks-checker-plus/src/popup.html
    /product/chrome-extentions/google-tasks-checker-plus/src/reset.css

### printf option ( -p )

see also list command's printf option.

## sync ( rsync )

recursive file synchronization.

### sync from dropbox

dropbox-api sync dropbox:<source\_dir> <target\_dir> \[options\]

    > dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png

### sync to dropbox

dropbox-api sync <source\_dir> dropbox:<target\_dir> \[options\]

    > dropbox-api sync /tmp/product dropbox:/work/src
    upload background.html /work/src/background.html
    upload external.png /work/src/external.png
    upload icon-128.png /work/src/icon-128.png

### delete option ( -d )

    > dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product -d
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    remove background.html.tmp

### dry run option ( -n )

    > dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product -dn
    !! enable dry run !!
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    remove background.html.tmp

### verbose option ( -v )

    > dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product -dnv
    remote_base: /product/chrome-extentions/google-tasks-checker-plus/src
    local_base: /private/tmp/product
    ** download **
    skip background.html
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    skip icon.gif
    skip jquery-1.4.2.min.js
    skip main.js
    skip manifest.json
    skip options.html
    skip popup.html
    skip reset.css
    ** delete **
    skip background.html
    remove background.html.tmp
    skip icon.gif
    skip jquery-1.4.2.min.js
    skip main.js
    skip manifest.json
    skip options.html
    skip popup.html
    skip reset.css

## cp

copy file or directory.

- alias

    copy

- syntax

    dropbox-api cp <source\_file> <target\_file>

### Example

    dropbox-api cp memo.txt memo.txt.bak

## mv

move file or directory.

- alias

    move

- syntax

    dropbox-api mv <source\_file> <target\_file>

### Example

    dropbox-api mv memo.txt memo.txt.bak

## mkdir

make directory.

\*no error if existing, make parent directories as needed.\*

- alias

    mkpath

- syntax

    dropbox-api mkdir <directory>

### Example

    dropbox-api mkdir product/src

## rm

remove file or directory.

\*remove the contents of directories recursively.\*

- alias

    rmtree

- syntax

    dropbox-api rm <file\_or\_directory>

### Example

    dropbox-api rm product/src

## get

download file from dropbox.

- alias

    dl, download

- syntax

    dropbox-api get dropbox:<dropbox\_file> <file>

### Example

    dropbox-api get dropbox:/Public/foo.txt /tmp/foo.txt

## put

upload file to dropbox.

- alias

    up, upload

- syntax

    dropbox-api put <file> dropbox:<dropbox\_dir>

### Example

    dropbox-api put /tmp/foo.txt dropbox:/Public/

### verbose option ( -v )

A progress bar is displayed.

    dropbox-api put /tmp/1GB.dat dropbox:/Public/
    100% [=====================================================================================>]

## uid

Get your accound UID

### Example

    dropbox-api uid

# COPYRIGHT

Copyright 2012- Shinichiro Aska

The standalone executable contains the following modules embedded.

# LICENSE

Released under the MIT license. http://creativecommons.org/licenses/MIT/

# COMMUNITY

- [https://github.com/s-aska/dropbox-api-command](https://github.com/s-aska/dropbox-api-command) - source code repository, issue tracker
