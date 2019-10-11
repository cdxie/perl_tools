#!/usr/bin/perl
use strict;
use warnings;

open IN,"test.wav.list";
open OUT,">wav.scp";
open OUT1,">utt2spk";
open OUT2,">spk2utt";
open OUT3,">sogou_test_fea.list";

my @arr;
my $id;
my $path;

while (<IN>)
{
	chomp;
	$path=$_;
    @arr = split(/\//,$_);
    $id = $arr[$#arr];
	$id=~s/\.wav//g;
    print OUT "$id $path\n";   
    print OUT1 "$id $id\n";   
    print OUT2 "$id $id\n";   
    print OUT3 "$_ /search/speech/cdxie/kaldi_181214/egs/babel/sed_train_deep/exp/test_applause_laughter_audioset/$id.plp\n";   

}

close IN;
close OUT;
close OUT1;
close OUT2;
close OUT3;
