#!/usr/bin/perl
use strict;
use warnings;

my $ips = {};
my $ip  = "";
# default port or give it as a CLI argument like
# cat iguana.log | nn_ips.pl 7774
my $port = 17775 || shift;
my $self = '139.99.208.174';
while (<>) {
        if ( m!$self:$port\s+([0-9.]+):!) {
                $ip = $1;
                my $cmd = "netstat -an|grep $port";
                print "Running $cmd ...";
                my $out = qx{$cmd};
                #print "Hops: $out\n";
                my $hops = $out =~ tr/\n//;
                $hops--;
                print "$hops hops\n";
                $ips->{$ip} = $hops;
        }
}

my @sorted = sort { $ips->{$a} <=> $ips->{$b} } keys %$ips;

print "Closest NN IPs:\n";

for my $ip (@sorted) {
        print "curl --url \"http://127.0.0.1:$port\" --data \"{\\\"agent\\\":\\\"iguana\\\",\\\"method\\\":\\\"addnotary\\\",\\\"ipaddr\\\":\\\"$ip\\\"}\"\n";
}
