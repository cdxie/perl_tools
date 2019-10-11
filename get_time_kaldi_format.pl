#!/usr/bin/perl
use strict;
use warnings;

my $bin="/search/speech/cdxie/ted/speech_data/feat-to-len";
my $filename="far_data_tmtm_ori";
my $infile="$filename/allfeat.scp";
my $tempfile="temp_${filename}.txt";
open IN,"$infile";
#open OUT,">$tempfile";

#my @args = stat ($infile);
#my $size = $args[7];
#print "$size\n";
if (! -e $tempfile) 
{
  system("$bin scp:$infile ark,t:$tempfile");
}

close IN;

open IN,"$tempfile";
my $sum_time = 0;
my @arr;

while (<IN>)
{
	chomp;
    @arr = split(/\s+/,$_);
    $sum_time += $arr[1]/100;
}
$sum_time = $sum_time/ 3600;

print "Time of $filename :: $sum_time hours\n";

close IN;

