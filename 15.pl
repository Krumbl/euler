#!/usr/bin/perl

use strict;
use bignum;

my $x = 20;
#print factorial(3);
my $a = factorial(2 * $x) / (factorial($x) * factorial($x));
print "$a \n";



exit;

sub factorial {
	my $n = shift @_;
	my $ret = 1;
	for (my $i = 1; $i <= $n; $i++) {
		$ret *= $i;
	}
	return $ret;
}
