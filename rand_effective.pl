#!/usr/bin/perl
use List::Util 'shuffle';


@a=();
$i=0;
open(IN,"1_ctm_cts_agc_2_label.txt");
while(<IN>)
{
    $a[$i]=$_;
	$i++;
}
close IN;
print "totalline:$i\n";
@ind = (0..$i-1);
@index = shuffle(@ind);
open(OUT,">1_ctm_cts_agc_2_label_chg.txt");
foreach $i(@index)
{
	print  OUT $a[$i];
}
