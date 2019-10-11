#!/usr/bin/perl
use strict;
use warnings;

open IN,"list";
my @list;
chomp(@list=<IN>);
close IN;

my $name;
my $file;
my @arr;
my $sec;
my $lab;
my @time;
my $bgt;
my $ent;
my $dur;

foreach $file(@list) 
{
	$name=$file;
    $name=~s/\.txt//g;
	open IN,"$file";
	open OUT,">fullrttm_$name";
	while (<IN>)
	{
		chomp;
		@arr=split(/\s+/,$_);
		$sec=$arr[0];
		@time=split(/\,/,$sec);
		$bgt=$time[0];
        $bgt=~s/\[//g;
        $bgt=sprintf("%.4f",$bgt);
		$ent=$time[1];
        $ent=~s/\]//g;
		$ent=sprintf("%.4f",$ent);
		$dur=sprintf("%.4f",$ent-$bgt);
		if (@arr>3)
		{
			print OUT "$name 1 $bgt $dur <NA> <NA> $arr[3] <NA> <NA>\n";
		}
		else
		{
			print OUT "$name 1 $bgt $dur <NA> <NA> other <NA> <NA>\n";
		}
	}
	close IN;
	close OUT;
}


