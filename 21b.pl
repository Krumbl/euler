#!/usr/bin/perl

use strict;
use Euler;

my @primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97);

#my @f = factors(220);
#print "@f\n";
#my @d = divisors(@f);
#print "@d\n";

#divisors(@f);

#print sum(1,2,3);


work();

exit;

sub work {
	my $n = 10000;
	my @d;
	push (@d, [0]);
	foreach my $i (1 .. $n) {
		push (@d, [divisors(factors($i))]);
	#	print "$i: @{$d[-1]}\n";
	}
	
	# @dd[n] = @d[n-1]
	my @dd = map { [sum(@$_) , [@$_]] } @d;
	
	foreach my $i (1 .. $n) {
		print "$i: $dd[$i][0] (",join(",",@{$dd[$i][1]}),")\n";
	}
	
	my $sum = 0;
	foreach my $i (1 .. $n) {
		if ($i == $dd[$dd[$i][0]][0] and $i != $dd[$i][0]) {
			print "amicable: $i $dd[$i][0]\n";
			$sum += $i;
		}
	}
	print "sum: $sum\n";
}

sub divisors {
	my @factors = @_;

#	my %tmp;
#	for (my $i = 0; $i < scalar @factors; $i++) {	
#		$tmp{$i} = $factors[$i];
#	}
#	foreach (keys %tmp) {
#		print $tmp{$_};
#		print "\n";
#	}

	my %ret;

	foreach my $i (1 .. (2 ** @factors) - 2) {
		my $bin = sprintf("%b", $i);
#		print "$i=$bin\n";
		
		my @bb = reverse(split(//, $bin));

		my $v = 1;
		for (my $j = 0; $j < scalar @bb; $j++) {
#			print "$j: $bb[$j]\n";
			if ($bb[$j]) {
#				print "v: $v\n";
				$v *= $factors[$j];
			}
		}
		if ($v != 1) {
#			print "add $v\n";
			$ret{$v} = $v;
		}

	}	
	
#	foreach (keys %ret) {
#		print $ret{$_};
#		print "\n";
#	}
#	print keys %ret;
#	print "\n";
	return (1, sort { $a <=> $b } keys %ret);
}


sub factors {
	my $num = shift @_;

	my @factors;
	
#BAR:	while ($num != 1) {
FOO: 		foreach my $p (@primes) {
#			print "check $p";
			if ($num % $p == 0) {
				#	print "isfactor\n";
				push(@factors, $p);
				$num /= $p;
				redo FOO;
			}
		}
#		last BAR;
	if ($num != 1) {
		push(@factors, $num);
	}
#	}
	
	return @factors;
}
