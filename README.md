# Dropbox API Command

Dropbox API Wrapper Command

- [github](https://github.com/s-aska/dropbox-api-command)
- [official](http://doc.7kai.org/Product/DropboxAPICommand/README)

## Commands
- ls
- **find**
- **sync**
- cp
- mv
- rm
- mkdir
- get
- put
- uid

## Install

    cpanm JSON Path::Class Net::Dropbox::API DateTime::Format::Strptime
    
    wget https://github.com/s-aska/dropbox-api-command/raw/master/dropbox-api
    cp dropbox-api ~/bin/dropbox-api
    chmod +x ~/bin/dropbox-api

### Get API Key and API Secret

    https://www.dropbox.com/developers
    My Apps => Create an App

### Get Access Token and Access Secret

    > dropbox-api setup
    Please Input API Key: ***************
    Please Input API Secret: ***************
    URL: http://api.dropbox.com/0/oauth/authorize?oauth_token=***************&oauth_callback=
    Please Access URL and press Enter
    OK?
    success!

## help

disp help.

- alias
  - \-
- syntax
  - dropbox-api help [&lt;command&gt;]

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
            %Tk ... DateTime ‘strftime’ function

## ls

file list view.

- alias
  - list
- syntax
  - dropbox-api ls &lt;dropbox\_path&gt;

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
    
        %Tk ... DateTime ‘strftime’ function
                <http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime_Patterns>

## find

recursive file list view.

- alias
  - \-
- syntax
  - dropbox-api find &lt;dropbox\_path&gt; [options]

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

### sync from dropbox

dropbox-api sync dropbox:&lt;source\_dir&gt; &lt;target\_dir&gt; [options]

    > dropbox-api sync dropbox:/product/google-tasks-checker-plus/src /tmp/product
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png

### sync to dropbox

dropbox-api sync &lt;source\_dir&gt; dropbox:&lt;target\_dir&gt; [options]

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
  - copy
- syntax
  - dropbox-api cp &lt;source\_file&gt; &lt;target\_file&gt;

### Example

    dropbox-api cp memo.txt memo.txt.bak

## mv

move file or directory.

- alias
  - move
- syntax
  - dropbox-api mv &lt;source\_file&gt; &lt;target\_file&gt;

### Example

    dropbox-api mv memo.txt memo.txt.bak

## mkdir

make directory.

*no error if existing, make parent directories as needed.*

- alias
  - mkpath
- syntax
  - dropbox-api mkdir &lt;directory&gt;

### Example

    dropbox-api mkdir product/src

## rm

remove file or directory.

*remove the contents of directories recursively.*

- alias
  - rmtree
- syntax
  - dropbox-api rm &lt;file_or_directory&gt;

### Example

    dropbox-api rm product/src

## get

download file from dropbox.

- alias
  - dl, download
- syntax
  - dropbox-api get dropbox:&lt;dropbox_file&gt; <file>

### Example

    dropbox-api get dropbox:/Public/foo.txt /tmp/foo.txt

## put

upload file to dropbox.

- alias
  - up, upload
- syntax
  - dropbox-api put &lt;file&gt; dropbox:&lt;dropbox_dir&gt;

### Example

    dropbox-api put /tmp/foo.txt dropbox:/Public/

## uid

Get your accound UID

### Example

    dropbox-api uid

## Changes

    Wed Apr  6 17:24:46 JST 2011
        - Added sub command uid (sylvainfilteau)
        - Added upload-to-dropbox command (sylvainfilteau)

## License
Released under the [MIT license](http://creativecommons.org/licenses/MIT/).
