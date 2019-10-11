#!/usr/bin/perl
use strict;
use warnings;

open IN,"label_map";
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

open IN,"ctm";

my @arr;
my $id;
my $bgtf;
my $durf;
my $sym_ctm;
my %id_hash;
my $tmp;

while (<IN>)
{
	chomp;
    @arr = split(/\s+/,$_);
    $id = $arr[0];
	#print "$arr[2] $arr[3]\n";
	$bgtf = $arr[2]*100;
	$durf = $arr[3]*100;
	$durf = sprintf("%s",$durf);
    $sym_ctm =$arr[$#arr];
	if(!(exists $id_hash{$id}))
	  {
         if (exists $kws_map{$sym_ctm})
		  {
		     $tmp = " ".$kws_map{$sym_ctm};
			 $id_hash{$id} = $tmp x $durf;   
          }
		 else
		  {
             $tmp = " "."0";
			 $id_hash{$id}=$tmp x $durf;
		  }
	  }
	 else
	  {
         if (exists $kws_map{$sym_ctm})
		  {
		     $tmp = " ".$kws_map{$sym_ctm};
			 $id_hash{$id} .=$tmp x $durf;   
          }
		 else
		  {
             $tmp = " "."0";
			 $id_hash{$id} .=$tmp x $durf;
		  }	 
	  }
}
close IN;

open OUT,">ctm_2_label.txt";
my $key;

foreach $key (keys %id_hash)
	{
	   print OUT "$key$id_hash{$key}\n";
    }

close OUT;

