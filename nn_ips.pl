#!/usr/bin/perl
use strict;
use warnings;

#my $traceroute = "traceroute -I -n";
my $traceroute = "traceroute -n -m10";
my $ips = {};
while (<>) {
	my $ip;
	if ( m!NN_CONNECT to \(tcp://(.*):7775\)! ) {
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
#my @sorted = map  { $_->[0] } 
#			 sort { $a->[1] cmp $b->[1] }
#			 map  { [$_, $ips->{$_} ]   } keys %$ips;
my @sorted = sort { $ips->{$a} <=> $ips->{$b} } keys %$ips;

print "Closest NN IPs:\n";
print join("\n", "curl --url \"http://127.0.0.1:7776\" --data \"{\\\"agent\\\":\\\"iguana\\\",\\\"method\\\":\\\"addnotary\\\",\\\"ipaddr\\\":\\\"". @sorted) . "\\\"}\"\n";
