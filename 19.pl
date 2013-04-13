#!/usr/bin/perl

use strict;


my @monthDays = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

# days SUN-SAT = 0-7

my $day = 2; # 1 Jan 1901

my $total = 0;

for (my $y = 1901; $y <= 2000; $y++) {
	print "YEAR $y\n";
	for (my $m = 0; $m < scalar @monthDays; $m++) {
		print "MONTH $m $day\n"; 
		#print "days: $monthDays[$m]\n";
		# if sunday on starting new month
		if (!$day) {
			print "FIRST SUNDAY!\n";
			$total++;
		}
		$day += $monthDays[$m];

		# check leap year
		if ($y % 4 == 0 && $m == 1) {
			print "LEAP YEAR!\n";
			$day += 1;
		}
		$day %= 7;
#		for (my $d = 0; $d <= $monthDays[$m]; $d++) {
			#print "$d $m $y\n";
			#day %= 7;
#		}
	}
}


print "Sundays: $total\n";


exit;


