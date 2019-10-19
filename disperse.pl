#!/usr/bin/env perl
use strict;
use warnings;
my $cli = shift || "komodo-cli";
my $balance = qx{$cli getbalance};
print "# Current Balance=$balance\n";
my %addresses = (
	# address => percent
	"RQZXbeVihmTkEeZ6fBXtSpg3BywjmVosYS" => 1.0, # jeezy
#	"RGjwWtkCKvHCQZCJhJ66XwjALSRdpWjzYi" => .45, # duke
#	"RF79i22W3YXMGsjzBLXNxU5KvWe31dG5pQ" => .10  # projects
);

my $self = "RVxow6SGPCjL2TxfTcztxMWeJWgS5rZTE6";

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
   # sometimes an f4a period can make blocks take a while
   print "sleep 120; $cmd\n";
}
