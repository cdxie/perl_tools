#!/usr/bin/perl
use strict;
use warnings;

open IN,"rttm";
open OUT,">ctm";
open OUT1,">label";

my @arr;
my $id;
my $ch;
my $bt;
my $dt;
my $te;
my @ar;

while (<IN>)
{
	chomp;
	@arr = split(/\s+/,$_);
    $id=$arr[0];
	$ch=$arr[1];
	$bt=$arr[2];
    $dt=$arr[3];
    $te=$arr[6];
	@ar = split(/\(/,$te);
	print OUT "$id $ch $bt $dt $ar[0]\n";
	print OUT1 "$ar[0]\n";

}

close IN;
close OUT;
close OUT1;
