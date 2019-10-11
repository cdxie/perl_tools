#!/usr/bin/perl
use strict;
use warnings;

open IN,"online_1st_clean.vad.result";
open OUT,">segments_online_1st_clean_above_120";

my $line;
my @arr;
my $id;
my $bgtime;
my $edtime;
my $dur;
my $bg;
my $ed;

while (<IN>)
{
	chomp;
    $line=$_;
	if ($line=~m/\[(\S+).wav\]/)
	{
		@arr=split(/\//,$1);
		$id=$arr[$#arr];
		while (<IN>)
		{
           chomp;
		   last if ($_=~m/\./);
           ($bgtime,$edtime)=split(/\,/,$_);
		   $bgtime=~s/\[//g;
		   $edtime=~s/\]//g;
		   $bgtime=sprintf("%s",$bgtime);
		   $edtime=sprintf("%s",$edtime);
		   $dur=$edtime - $bgtime;
		   if ($dur > 120) 
		   {
		     $bg=sprintf("%04s",$bgtime);
		     $ed=sprintf("%04s",$edtime);
             print OUT "$id\_$bg\_$ed $id $bgtime $edtime\n";
		   }
		}
	}
}

close IN;
close OUT;



