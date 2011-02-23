# Dropbox Sync

Dropbox上のコンテンツとローカルコンテンツを同期するスクリプトです。 `rsync -rz --delete Dropbox localhost`

- Dropbox側からローカルにのみ転送します、アップロードは行いません。
- ローカルにのみ存在するファイルを削除するオプションがあります。
- DropboxへのAPI登録、OAUTHの認証手順は各自行って下さい。
- スクリプトのバグで誤ってファイルが消えてしまっても私は責任を負いきれません。

## require module

    cpanm JSON::XS Path::Class Net::Dropbox::API

## Get API Key and Secret

    https://www.dropbox.com/developers

    My Apps => Create an App

    set config.pl
        key => API Key
        secret => API Secret

## Get Access Token and Access Secret

    > perl login.pl
    URL: http://api.dropbox.com/0/oauth/authorize?oauth_token=vnyvq29cdtafk47&oauth_callback=
    Please Access URL and AUTH
    # Open Your Browser and Access URL
    # Display Success
    OK?

    access_token: **************
    access_secret: **************

    set config.pl
        access_token => access_token
        access_token => access_secret

## Run sync.pl

    # Download Only
    perl sync.pl -f DROPBOX_PATH -t LOCAL_PATH

    # Download and Delete
    perl sync.pl -d 1 -f DROPBOX_PATH -t LOCAL_PATH

    # Example: perl sync.pl /product/dropbox-get /tmp/dropbox-get
