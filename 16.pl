#!/usr/bin/perl

use strict;
use bignum;

my $n = 2 ** 1000;

my @a = split(//, $n);

my $r = 0;
foreach my $i (@a) {
	$r += $i;
}

print "$r \n";


exit;
