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
	"RVwS8ghZtR89QxLXPGPJtqZEQ6KmfP7WEZ" => .10, # airdrop
	"RF79i22W3YXMGsjzBLXNxU5KvWe31dG5pQ" => .10, # projects
);

my $self = "RXrQPqU4SwARri1m2n7232TDECvjzXCJh4";

# leave 11 and disperse rest
my $reserve = 11;
my $disperse= $balance - $reserve;

if ($disperse > 0) {
   while (my ($addr,$pct) = each %addresses) {
	my $amount = sprintf "%.8f", $pct * $disperse;
	my $cmd = "$cli sendtoaddress $addr $amount";
	print "$cmd\n";
   }
   my $cmd = "$cli sendtoaddress $self 10.0";
   print "$cmd\n";
   $cmd = $ENV{HOME} . "/nntools/autosplit.sh";
   print "sleep 180; $cmd\n";
}
