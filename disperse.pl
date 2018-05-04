#!/usr/bin/env perl
use strict;
use warnings;
my $cli = shift || "komodo-cli";
my $balance = qx{$cli getbalance};
print "# Current Balance=$balance\n";
my %addresses = (
	# address => percent
	"RGZBQh4AqziCZ6rS8ps1kLqD7ribbCpv9a" => .40, # jeezy
	"RBSEv7nJ1wciriVyLFWotQ8tBvS2rKwYtz" => .40, # duke
	"AIRDROP"		             => .10, # airdrop
	"PROJECTS"		             => .10, # projects
);

# leave 11 and disperse rest
my $reserve = 11;
my $disperse= $balance - $reserve;

if ($disperse > 0) {
   while (my ($addr,$pct) = each %addresses) {
	my $amount = sprintf "%.8f", $pct * $disperse;
	my $cmd = "$cli sendtoaddress $addr $amount";
	print "$cmd\n";
   }
}
