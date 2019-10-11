#!/usr/bin/perl
use strict;
use warnings;

open IN,"map_list";
my $sym;
my $label;
my %kws_map;
while (<IN>)
{
	chomp;
    ($sym,$label) = split(/\s+/,$_);
	if(!(exists $kws_map{$sym}))
	  {
         $kws_map{$sym}=$label;   
	  }
}
close IN;

my $mlf="rttm";
open IN,"$mlf";
my @arr;
@arr=<IN>;
chomp(@arr);
close IN;

my @array;
my $i;
my $wav_name;
my $btime;
my $durtime;
my $etime;
my $spk;
my %id_records;

for ($i=0;$i<@arr;$i++)
{
  @array=split(/\s+/,$arr[$i]);
  $wav_name=$array[0];
  $btime=$array[2];
  $durtime=$array[3];
  $etime=$btime+$durtime;
  $spk=$array[6]; 
  $id_records{$wav_name}.="$btime $etime $spk;";
}

my $kw;
my @records;
my @info;
my $spkr;
my $bt=0;
my $et=0;
my @ar;
my $ksym;
my %sed;
my $kw1;
my @rcds;
my $j;
my @ifo;

foreach $kw (keys %id_records)
{
	open OUT,">$kw.answer.txt";
	@records=split(/;/,$id_records{$kw});
    for ($i=0;$i<@records;$i++)
     {
	    @info=split(/\s+/,$records[$i]);
        $bt=$info[0];
        $et=$info[1];
		$spkr=$info[2];
	    if(exists $kws_map{$spkr})
		 {
			@ar = split(/\,/,$kws_map{$spkr});
			foreach $ksym (@ar)
			{
				$sed{$ksym}.="$bt $et;";
			}
		 }
	  }
	 foreach $kw1 (keys %sed)
	   {
		 @rcds=split(/;/,$sed{$kw1});
         for ($j=0;$j<@rcds;$j++)
		  {
			@ifo=split(/\s+/,$rcds[$j]);
			print OUT "$ifo[0]\t$ifo[1]\t$kw1\n";
		  }
		}
      %sed=();
	 close OUT;
}


