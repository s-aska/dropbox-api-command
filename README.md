[![Build Status](https://travis-ci.org/s-aska/dropbox-api-command.svg?branch=master)](https://travis-ci.org/s-aska/dropbox-api-command)
# NAME

App::dropboxapi - command line interface to access Dropbox API

# SYNOPSIS

```
dropbox-api put /tmp/foo.txt dropbox:/Public/
```

Run `dropbox-api help` for more options.

# DESCRIPTION

dropbox-api is a command line interface to access Dropbox API.

- ls
- find
- sync
- cp
- mv
- rm
- mkdir
- get
- put

# Install and Setup

## 1. Install

### 1-a) FreeBSD

```
pkg_add -r dropbox-api-command
```

### 1-b) Ubuntu

```
sudo apt-get install make gcc libssl-dev wget
wget https://raw.github.com/miyagawa/cpanminus/master/cpanm
sudo perl cpanm App::dropboxapi
```

### 1-c) CentOS

```
# CentOS 5
sudo yum install gcc gcc-c++ openssl-devel wget
# CentOS 6
sudo yum install gcc gcc-c++ openssl-devel wget perl-devel
wget https://raw.github.com/miyagawa/cpanminus/master/cpanm
sudo perl cpanm App::dropboxapi
```

### 1-d) OS X

```
# Install Command Line Tools for Xcode
open https://www.google.com/search?q=Command+Line+Tools+for+Xcode

curl -O https://raw.github.com/miyagawa/cpanminus/master/cpanm
sudo perl cpanm App::dropboxapi
```

## 2. Get API Key and API Secret

```perl
https://www.dropbox.com/developers
My Apps => Create an App
```

## 3. Get Access Token and Access Secret

```
> dropbox-api setup
Please Input API Key: ***************
Please Input API Secret: ***************
1. Open the Login URL: https://www.dropbox.com/oauth2/authorize?client_id=*****&response_type=code
2. Input code and press Enter: ***************
success! try
> dropbox-api ls
> dropbox-api find /
```

## 4. How to use Proxy

Please use -e option.

```
> HTTP_PROXY="http://127.0.0.1:8888" dropbox-api setup -e
```

# Sub Commands

## help

disp help.

- syntax

    dropbox-api help \[&lt;command>\]

### Example

```perl
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

Common Options
    -e enable env_proxy ( HTTP_PROXY, NO_PROXY )
    -D enable debug
    -v verbose
    -s sandbox mode, but this option has been removed.

See 'dropbox-api help <command>' for more information on a specific command.
```

### Example ( command help )

```
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
        %i ... id
        %n ... name
        %p ... path_display
        %P ... path_lower
        %b ... bytes
        %s ... size (e.g., 1K 234M 2G)
        %t ... server_modified
        %c ... client_modified
        %r ... rev
        %Tk ... DateTime 'strftime' function (server_modified)
        %Ck ... DateTime 'strftime' function (client_modified)
```

[http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime\_Patterns](http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime_Patterns)

## ls

file list view.

- alias

    list

- syntax

    dropbox-api ls &lt;dropbox\_path>

### Example

```
> dropbox-api list /product
d        - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
-   294557 Sun, 26 Dec 2010 21:55:59 +0000 /product/ex.zip
```

### human readable option ( -h )

print sizes in human readable format (e.g., 1K 234M 2G)

```
> dropbox-api ls /product -h
d        - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
-  287.7KB Sun, 26 Dec 2010 21:55:59 +0000 /product/ex.zip
```

### printf option ( -p )

print format.

```
> dropbox-api ls /product -p "%d\t%s\t%TY/%Tm/%Td %TH:%TM:%TS\t%p\n"
d       -       2011/02/24 06:58:00     /product/chrome-extentions
-       287.7KB 2010/12/26 21:55:59     /product/ex.zip

    %d ... is_dir ( d: dir, -: file )
    %i ... id
    %n ... name
    %p ... path_display
    %P ... path_lower
    %b ... bytes
    %s ... size (e.g., 1K 234M 2G)
    %t ... server_modified
    %c ... client_modified
    %r ... rev
    %Tk ... DateTime 'strftime' function (server_modified)
    %Ck ... DateTime 'strftime' function (client_modified)
```

[http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime\_Patterns](http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime_Patterns)

## find

recursive file list view.

- syntax

    dropbox-api find &lt;dropbox\_path> \[options\]

### Example

```
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
```

### printf option ( -p )

see also list command's printf option.

## sync ( rsync )

recursive file synchronization.

### sync from dropbox

dropbox-api sync dropbox:&lt;source\_dir> &lt;target\_dir> \[options\]

```
> dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product
download /private/tmp/product/external.png
download /private/tmp/product/icon-32.png
download /private/tmp/product/icon-128.png
```

### sync to dropbox

dropbox-api sync &lt;source\_dir> dropbox:&lt;target\_dir> \[options\]

```
> dropbox-api sync /tmp/product dropbox:/work/src
upload background.html /work/src/background.html
upload external.png /work/src/external.png
upload icon-128.png /work/src/icon-128.png
```

### delete option ( -d )

```
> dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product -d
download /private/tmp/product/external.png
download /private/tmp/product/icon-32.png
download /private/tmp/product/icon-128.png
remove background.html.tmp
```

### dry run option ( -n )

```
> dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product -dn
!! enable dry run !!
download /private/tmp/product/external.png
download /private/tmp/product/icon-32.png
download /private/tmp/product/icon-128.png
remove background.html.tmp
```

### verbose option ( -v )

```
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
```

## cp

copy file or directory.

- alias

    copy

- syntax

    dropbox-api cp &lt;source\_file> &lt;target\_file>

### Example

```
dropbox-api cp memo.txt memo.txt.bak
```

## mv

move file or directory.

- alias

    move

- syntax

    dropbox-api mv &lt;source\_file> &lt;target\_file>

### Example

```
dropbox-api mv memo.txt memo.txt.bak
```

## mkdir

make directory.

\*no error if existing, make parent directories as needed.\*

- alias

    mkpath

- syntax

    dropbox-api mkdir &lt;directory>

### Example

```
dropbox-api mkdir product/src
```

## rm

remove file or directory.

\*remove the contents of directories recursively.\*

- alias

    rmtree

- syntax

    dropbox-api rm &lt;file\_or\_directory>

### Example

```
dropbox-api rm product/src
```

## get

download file from dropbox.

- alias

    dl, download

- syntax

    dropbox-api get dropbox:&lt;dropbox\_file> &lt;file>

### Example

```
dropbox-api get dropbox:/Public/foo.txt /tmp/foo.txt
```

## put

upload file to dropbox.

- alias

    up, upload

- syntax

    dropbox-api put &lt;file> dropbox:&lt;dropbox\_dir>

### Example

```
dropbox-api put /tmp/foo.txt dropbox:/Public/
```

### verbose option ( -v )

A progress bar is displayed.

```perl
dropbox-api put /tmp/1GB.dat dropbox:/Public/ -v
100% [=====================================================================================>]
```

## Tips

### Retry

```
#!/bin/bash

command='dropbox-api sync dropbox:/test/ /Users/aska/test/ -vde'

NEXT_WAIT_TIME=0
EXIT_CODE=0
until $command || [ $NEXT_WAIT_TIME -eq 4 ]; do
    EXIT_CODE=$?
    sleep $NEXT_WAIT_TIME
    let NEXT_WAIT_TIME=NEXT_WAIT_TIME+1
done
exit $EXIT_CODE
```

# COPYRIGHT

Copyright 2012- Shinichiro Aska

The standalone executable contains the following modules embedded.

# LICENSE

Released under the MIT license. http://creativecommons.org/licenses/MIT/

# COMMUNITY

- [https://github.com/s-aska/dropbox-api-command](https://github.com/s-aska/dropbox-api-command) - source code repository, issue tracker
