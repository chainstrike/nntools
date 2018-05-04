#!/usr/bin/env perl
use strict;
use warnings;
my $cli = shift || "komodo-cli";
my $balance = qx{$cli getbalance};
print "Current Balance=$balance\n";
my %addresses = (
	# address => percent
	"RGZBQh4AqziCZ6rS8ps1kLqD7ribbCpv9a" => .45, # jeezy
	"RBSEv7nJ1wciriVyLFWotQ8tBvS2rKwYtz" => .45, # duke
	"AIRDROP"		                     => .10, # airdrop
);

# leave 10% and disperse 90%
my $percent = 0.10;
my $reserve = 11;
my $disperse= $balance - $reserve;

if ($disperse > 0) {
   while (my ($addr,$pct) = each %addresses) {
	my $amount = sprintf "%.8f", $pct * $disperse;
	my $cmd = "$cli sendtoaddress $addr $amount";
	print "$cmd\n";
   }
}
