#!perl

use strict;
use JSON::XS;
use File::Spec::Functions;
use File::Basename qw(dirname);
use Net::Dropbox::API;
use Path::Class;
use Getopt::Std;

my %opts;
getopt('dft', \%opts);

my $delete = $opts{d};
my $base   = $opts{f};
my $dir    = $opts{t};
die "missing dest dir $dir" if !-d $dir;
my $cache_file = catfile( dirname(__FILE__), '.dropbox.cache' );
my $cache = -f $cache_file ? decode_json(file($cache_file)->slurp) : {};
die $@ if $@;
my $config_file = catfile( dirname(__FILE__), $ENV{'CONFIG_PATH'} || 'config.pl' );
my $config = do $config_file or die "load error $config_file";
$config->{key} or die "please set config key.";
$config->{secret} or die "please set config secret.";
$config->{access_token} or die "please set config access_token.";
$config->{access_secret} or die "please set config access_secret.";
my $box = Net::Dropbox::API->new($config);
$box->context('dropbox');

my $files;
my $find;
$find = sub {
    my $path = shift;
    $path = substr $path, 1 if substr($path, 0, 1) eq '/';
    #warn "find $path";
    my $list = $box->list($path);
    my @dirs;
    for my $content (@{$list->{contents}}) {
        #warn "content $content->{path}";
        my $l_path = $content->{path};
        $l_path=~s|^$base/?||;
        #warn "push $l_path";
        $files->{$l_path} = $content;
        if ($content->{is_dir}) {
            push @dirs, $content;
            my $cur = dir($dir, $l_path);
            if (!-d $cur) {
                warn "mkpath $cur";
                $cur->mkpath;
            }
        } else {
            if (
                exists $cache->{$l_path} &&
                -f file($dir, $l_path) &&
                $cache->{$l_path}->{modified} eq $files->{$l_path}->{modified}
            ) {
                warn "skip $content->{path}";
            } else {
                warn "download $content->{path}";
                my $file = file($dir, $l_path);
                $file->dir->mkpath if !-d $file->dir;
                $box->getfile(substr($content->{path}, 1), $file->absolute->stringify);
            }
        }
    }
    for my $content (@dirs) {
        $find->($content->{path}.'/');
    }
};
$find->($base);
my $fh = file($cache_file)->openw;
$fh->print(encode_json($files));
$fh->close;
exit if not $delete;
$dir = dir($dir);
my $dir_abs = $dir->absolute;
$dir->recurse(
    preorder => 0,
    depthfirst => 1,
    callback => sub {
        my $file = shift;
        my $path = $file->absolute;
        $path=~s|$dir_abs/?||;
        return if not length $path;
        #warn $path;
        if (not exists $files->{$path}) {
            if (-f $file) {
                warn "unlink $file";
                unlink $file;
            } elsif (-d $file) {
                warn "rmtree $file";
                dir($file)->rmtree;
            }
        }
    }
);

exit(0);
