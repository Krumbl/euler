#!/usr/bin/perl

use strict;

use Math::BigInt;

my $f = new Math::BigInt 1;
for my $i ( 2 .. 100) {
	$f = $f->bmul($i);
#	print "$f\n";
}

my $fs = $f->bstr();
print "$fs\n";
my $res = 0;
foreach my $s (split(//, $fs)) {
	print "$s\n";
	$res += $s;
}

print "res: $res\n";

exit;
