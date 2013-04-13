package Euler;
use Exporter 'import';
@EXPORT = qw(getPrimes sum divisors factors);

my @primes;

sub loadPrimes {
	return if scalar @primes;
	open (FILE, "primes.txt");
	while (<FILE>) {
		chomp;
		push (@primes, $_);
	}
	close (FILE);
}

sub getPrimes {
	loadPrimes();
	return @primes;
}

sub sum {
        my @n= @_;

        my $sum = 0;
        foreach my $i (@n) {
                $sum += $i;
        }
        return $sum;
}


sub divisors {
	my $num = shift @_;
	my @factors = factors($num);

        my %ret;

        foreach my $i (1 .. (2 ** @factors) - 2) {
                my $bin = sprintf("%b", $i);

                my @bb = reverse(split(//, $bin));

                my $v = 1;
                for (my $j = 0; $j < scalar @bb; $j++) {
                        if ($bb[$j]) {
                                $v *= $factors[$j];
                        }
                }
                if ($v != 1) {
                        $ret{$v} = $v;
                }

        }
        return (1, sort { $a <=> $b } keys %ret);
#        return sort { $a <=> $b } keys %ret;
}

sub factors {
        my $num = shift @_;

	loadPrimes();

        my @factors;
	
	my $sqrt = sqrt($num);
FOO:	foreach my $p (@primes) {
		last FOO if $p > $sqrt;
		if ($num % $p == 0) {
#       		print "isfactor\n";
			push(@factors, $p);
			$num /= $p;
			redo FOO;
		}
	}
        if ($num != 1) {
                push(@factors, $num);
        }

        return @factors;
}


1;
