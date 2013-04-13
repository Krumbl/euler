#!/usr/bin/perl

use strict;

my @array;

open (FILE, "<triangle.txt");
while (<FILE>) {
	chomp;
	unshift @array, [split(/ /)];
}
close (FILE);


#print $array[3][2];

for (my $i = 1; $i < scalar @array; $i++) {
#for (my $i = 1; $i < 3; $i++) {
	print "$i: ";
	my @tmparray;
	for (my $j = 0; $j < scalar @{$array[$i]}; $j++) {
		print "$array[$i][$j],";
#		print "\ntmp: @tmparray\n";
		$tmparray[$j] = solve($array[$i][$j], $array[$i - 1][$j], $array[$i - 1][$j + 1]);
#		print "$tmparray[$j],";
	}
	$array[$i] = [@tmparray];
	print "\n";
}

print "answer: " . $array[scalar @array -1][0] . "\n";

exit;

sub solve {
	my ($top, $left, $right) = @_;
#	print "solve for: $top $left $right ";
	
	$left = $top + $left;
	$right = $top + $right;

	if ($left > $right) {
		return $left;
	}
	return $right;

}
