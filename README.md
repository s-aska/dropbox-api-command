# Dropbox API Command

Dropbox API Wrapper Command

## Commands
- list ... dropbox file list view
  - printf option.
  - human readable option
- find ... dropbox file recursive list view
  - printf option.
- sync ... dropbox file sync to local ( download only )
  - delete option. ( rsync --delete option like. )
  - dry-run option.
- copy     ... copy file or directory
- move     ... move file or directory
- mkdir    ... make directory
- download ... download file
- upload  ... upload file

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

## list ( ls )

dropbox-api list|ls DROPBOX_PATH

    > dropbox-api list /product
    d        - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
    d        - Thu, 24 Feb 2011 07:30:02 +0000 /product/dot-files
    d        - Wed, 23 Feb 2011 05:51:05 +0000 /product/dropbox-sync-down
    -   294557 Sun, 26 Dec 2010 21:55:59 +0000 /product/ex.zip
    d        - Thu, 24 Feb 2011 03:49:03 +0000 /product/markdown-binder-plack
    d        - Fri, 25 Feb 2011 11:11:42 +0000 /product/MasterSpark
    d        - Tue, 26 Oct 2010 05:14:21 +0000 /product/mime-parser-delux

### human readable option ( -h )

print sizes in human readable format (e.g., 1K 234M 2G)

    > dropbox-api list /product -h
    d        - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
    d        - Thu, 24 Feb 2011 07:30:02 +0000 /product/dot-files
    d        - Wed, 23 Feb 2011 05:51:05 +0000 /product/dropbox-sync-down
    -  287.7KB Sun, 26 Dec 2010 21:55:59 +0000 /product/ex.zip
    d        - Thu, 24 Feb 2011 03:49:03 +0000 /product/markdown-binder-plack
    d        - Fri, 25 Feb 2011 11:11:42 +0000 /product/MasterSpark
    d        - Tue, 26 Oct 2010 05:14:21 +0000 /product/mime-parser-delux

### printf option ( -p )

print format.

    %d ... is_dir ( d: dir, -: file )
    %p ... path
    %b ... bytes
    %s ... size ( eg. 1.2Kb )
    %i ... icon
    %e ... thumb_exists
    %M ... mime_type
    %t ... modified time
    %r ... revision
    
    %Tk ... DateTime ‘strftime’ function
            <http://search.cpan.org/dist/DateTime/lib/DateTime.pm#strftime_Patterns>

    > dropbox-api list /product -p "%d\t%s\t%TY/%Tm/%Td %TH:%TM:%TS\t%p\n"
    d       -       2011/02/24 06:58:00     /product/chrome-extentions
    d       -       2011/02/24 07:30:02     /product/dot-files
    d       -       2011/02/23 05:51:05     /product/dropbox-sync-down
    -       287.7KB 2010/12/26 21:55:59     /product/ex.zip
    d       -       2011/02/24 03:49:03     /product/markdown-binder-plack
    d       -       2011/02/25 11:11:42     /product/MasterSpark
    d       -       2010/10/26 05:14:21     /product/mime-parser-delux

## find

dropbox-api find DROPBOX_PATH

    > dropbox-api find /product/chrome-extentions/google-tasks-checker-plus
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

## sync

dropbox-api sync **dropbox:**/DROPBOX\_PATH LOCAL\_PATH

    > dropbox-api sync /product/chrome-extentions/google-tasks-checker-plus/src /tmp/product
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png

### delete option ( -d )

    > dropbox-api sync dropbox:/product/chrome-extentions/google-tasks-checker-plus/src /tmp/product -d
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    remove background.html.tmp

### dry run option ( -n )

    > dropbox-api sync dropbox:/product/chrome-extentions/google-tasks-checker-plus/src /tmp/product -nd
    !! enable dry run !!
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    remove background.html.tmp

### verbose option ( -v )

    > dropbox-api sync dropbox:/product/chrome-extentions/google-tasks-checker-plus/src /tmp/product -vnd
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

## copy ( cp )

dropbox-api copy|cp source\_file target\_file

    dropbox-api copy memo.txt memo.txt.bak

## move ( mv )

dropbox-api move|mv source\_file target\_file

    dropbox-api move memo.txt memo.txt.bak

## mkdir ( mktree )

dropbox-api mkdir|mktree directory\_name

    dropbox-api mkdir product/src

## delete ( rm )

dropbox-api delete|rm file\_or\_directory

    dropbox-api delete product/src

## upload ( up )

dropbox-api upload upload\_file **dropbox:**/remote\_path

    dropbox-api upload /tmp/foo.txt dropbox:/Public/

## download ( dl )

dropbox-api download **dropbox:**/download\_file local\_path

    dropbox-api download dropbox:/Public/foo.txt /tmp/foo.txt

## License
Released under the [MIT license](http://creativecommons.org/licenses/MIT/).
