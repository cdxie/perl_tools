#!/usr/bin/perl
use strict;
use warnings;


open IN,"rttm";
open OUT,">list";
my @arr;
my $id;
my $bt;
my $dt;
my $te;
my @ar;
my $sym;
my %id_records;

while (<IN>)
{
	chomp;
	@arr = split(/\s+/,$_);
    $te=$arr[6];
	print OUT "$te\n";
}

close IN;
close OUT;