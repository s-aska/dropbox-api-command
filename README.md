# Dropbox API Command

Dropbox API Wrapper Command

## Commands
- ls   ... dropbox file list view
- find ... dropbox file recursive list view
- sync ... dropbox file sync to local ( download only )
  - delete option. ( rsync --delete option like. )
  - dry-run option.

## Install

    cpanm JSON Path::Class Net::Dropbox::API DateTime::Format::Strptime
    
    git clone git@github.com:s-aska/dropbox-api-command.git
    cd dropbox-api-command
    cp dropbox-api ~/bin/dropbox-api
    chmod +x ~/bin/dropbox-api

### Get API Key and Secret

    https://www.dropbox.com/developers
    My Apps => Create an App

### Get Access Token and Access Secret

    > perl dropbox-setup
    Please Input API Key: ***************
    Please Input API Secret: ***************
    URL: http://api.dropbox.com/0/oauth/authorize?oauth_token=***************&oauth_callback=
    Please Access URL and AUTH
    OK?
    success!

## file list

dropbox-api ls DROPBOX_PATH

    > dropbox-api ls /product
     dir          - Thu, 24 Feb 2011 06:58:00 +0000 /product/chrome-extentions
     dir          - Thu, 24 Feb 2011 07:30:02 +0000 /product/dot-files
     dir          - Wed, 23 Feb 2011 05:51:05 +0000 /product/dropbox-sync-down
    file    287.7KB Sun, 26 Dec 2010 21:55:59 +0000 /product/hoge.tar.gz
     dir          - Thu, 24 Feb 2011 03:49:03 +0000 /product/markdown-binder-plack
     dir          - Fri, 25 Feb 2011 11:11:42 +0000 /product/MasterSpark
     dir          - Tue, 26 Oct 2010 05:14:21 +0000 /product/mime-parser-delux

## file find

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

## file sync

### download

dropbox-api sync DROPBOX_PATH LOCAL_PATH

    > dropbox-api sync /product/chrome-extentions/google-tasks-checker-plus/src /tmp/product
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png

### delete option ( -d )

dropbox-api -d sync DROPBOX_PATH LOCAL_PATH

    > dropbox-api -d sync /product/chrome-extentions/google-tasks-checker-plus/src /tmp/product
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    remove background.html.tmp

### dry run option ( -n )

dropbox-api -nd sync DROPBOX_PATH LOCAL_PATH

    > dropbox-api -d sync /product/chrome-extentions/google-tasks-checker-plus/src /tmp/product
    !! enable dry run !!
    download /private/tmp/product/external.png
    download /private/tmp/product/icon-32.png
    download /private/tmp/product/icon-128.png
    remove background.html.tmp

### verbose option ( -v )

dropbox-api -vnd sync DROPBOX_PATH LOCAL_PATH

    > dropbox-api -vnd sync /product/chrome-extentions/google-tasks-checker-plus/src /tmp/product
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
