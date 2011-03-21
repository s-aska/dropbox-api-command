#!perl

use strict;
use File::Basename qw(dirname);
use JSON;
use Net::Dropbox::API;
use Path::Class;
my $config_file = file( dirname(__FILE__), $ENV{'CONFIG_PATH'} || 'dropbox-config.json' );
my $config = {};

print "Please Input API Key: ";
chomp( my $key = <STDIN> );
die 'Get API Key from https://www.dropbox.com/developers' unless $key;
$config->{key} = $key;

print "Please Input API Secret: ";
chomp( my $secret = <STDIN> );
die 'Get API Secret from https://www.dropbox.com/developers' unless $secret;
$config->{secret} = $secret;

$config->{callback_url} = '';
my $box = Net::Dropbox::API->new($config);
my $login_link = $box->login;
print "URL: $login_link\n";
print "Please Access URL and AUTH\n";
print "OK?";
<STDIN>;
$box->auth;
$config->{access_token} = $box->access_token;
$config->{access_secret} = $box->access_secret;
print "success! try\n";
print "> perl dropbox-api.pl ls\n";
print "> perl dropbox-api.pl find /\n";

$config_file->openw->print(encode_json($config));

exit(0);
