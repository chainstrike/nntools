#!/usr/bin/perl
use strict;
use warnings;

#my $traceroute = "traceroute -I -n";
my $traceroute = "traceroute -n -m10";
my $ips = {};
my $ip  = "";
# default port or give it as a CLI argument like
# cat iguana.log | nn_ips.pl 7774
my $port = 7776 || shift;
while (<>) {
        if ( m!NN_CONNECT to \(tcp://(.*):! ) {
                $ip = $1;
                my $cmd = "$traceroute $ip";
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
