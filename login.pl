#!perl

use strict;
use File::Spec::Functions;
use File::Basename qw(dirname);
use Net::Dropbox::API;
my $config_file = catfile( dirname(__FILE__), $ENV{'CONFIG_PATH'} || 'config.pl' );
my $config = do $config_file or die "load error $config_file";
$config->{key} or die "please set config key.";
$config->{secret} or die "please set config secret.";
$config->{callback_url} = '';
my $box = Net::Dropbox::API->new($config);
my $login_link = $box->login;
print "URL: $login_link\n";
print "Please Access URL and AUTH\n";
print "OK?";
<STDIN>;
$box->auth;
print "access_token: ", $box->access_token, "\n";
print "access_secret: ", $box->access_secret, "\n";

exit(0);
