#!/usr/bin/perl

use Time::HiRes qw/gettimeofday/;

use strict;

(my $s, my $ms) = gettimeofday();
my $start = $s * 1000 + $ms;
$start = `date +%s%N | cut -b1-13`;

my %known;

my @p4 = probability(4,1);

my @np6 = probability_sum(6, $#p4, @p4);
my @np8 = probability_sum(8, scalar @np6, @np6);
my @np12 = probability_sum(12, scalar @np8, @np8);

#my $total = 0;
#my @t = @np8;
#for my $i (0 .. scalar @t) {
#	print "$i : @t[$i]\n";
#	$total += @t[$i];
#}
#print "total: $total\n";

#my @p = probability(6, 3);
#print join(',', @p);
#print "\n";
#print "@p[8]\n";
#my $pv = probability_value(6,2,8);
#print "pv(6,2,8) = $pv\n";

($s, $ms) = gettimeofday();
#print "$s\n";
#print "$ms\n";
my $end = $s * 1000 + $ms;
$end = `date +%s%N | cut -b1-13`;
print "$start\n";
print "$end\n";
print "Time: " . ($end - $start) . "ms\n";


exit;

sub probability_sum {
	my ($sides, $dice, @probdice) = @_;

	my @p = [];

	for (my $d = 1; $d <= $dice; $d++) {
		my @pp = probability($sides, $d);
	#	print "@pp\n";
	#	print "@pp[4]\n";
	#
		# apply probability of getting $d
		foreach my $val(@pp) {
			$val = $val * @probdice[$d];
		}
	#
		@p[$d] = \@pp;
	#	print "@p6[$d]\n";
	#	push @{ $p6[$d] }, probability(6, $d);
	}


	my @np;
	foreach my $row(@p) {
	#	print "$row\n";
	#	foreach my $val(@$row) {
	#		print "$val, ";
	#	}
	#	print "\n";
		if (defined $row) {
			my @rowi = @$row;
			for my $i (0 .. $#rowi) {
	#			print "$i : @$row[$i]\n";
	#			$val = $val / 4;
				@np[$i] += @$row[$i];
			}
		}
	}

	return @np;
}

# array of probability to roll value at that index for number of $dice with amount of $sides
sub probability {
	my ($sides, $dice) = @_;

	my @p = [];
	for my $i (0 .. $dice) {
		@p[$i] = 0;
	}
	for (my $i = $dice; $i <= $sides * $dice; $i++) {
		@p[$i] = probability_value($sides, $dice, $i);
	}

	#@p = [1,2,3];
#	print "p $sides $dice = @p\n";
	return @p;
}

# probability to roll $value for number of $dice with amount of $sides
sub probability_value {
	my ($sides, $dice, $value) = @_;

	
	my $p = $known{$sides * 1000000000 + $dice + $value * 10000000000};
	# impossible rolls
	if (!defined $p) {
#		print "unknown!";
		if ($dice * $sides < $value) {
			$p = 0;
		} 
		# single die
		elsif ($dice == 1) {
			$p = 1 / $sides;
		} 
		# recurse multiple die
		else {
			for (my $i = 1; $i <= $value - $dice + 1; $i++) {
				$p += probability_value($sides, 1, $i) * probability_value($sides, $dice - 1, $value - $i);
			}
		}
		$known{$sides * 1000000000 + $dice + $value * 10000000000} = $p;
	}	

#	print "pv $sides, $dice, $value = $p\n";
	return $p;
}
