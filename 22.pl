#!/usr/bin/perl

use strict;

use Euler;

my @names;

open (FILE, "names.txt");
while (<FILE>) {
	chomp;
	# map { map { ord $_ - 64 } @$_ }
	push (@names, map { [split(//)] } sort(map { s/"//g; $_; } split(/,/)));
}
close (FILE);

#print "@names\n";

my $total = 0;
#foreach my $n (@names) {
for (my $i = 0; $i < scalar @names; $i++) {
	$total += ($i + 1) * sum(map { (ord $_) - 64 } @{$names[$i]});
}

print "total: $total\n";

exit;
