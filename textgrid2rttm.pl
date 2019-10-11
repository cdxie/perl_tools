#!/usr/bin/perl
use strict;
use warnings;

open IN,"list";
my @list;
chomp(@list=<IN>);
close IN;

my $name;
my $line;
my $num;
my @arr=();
my $i;
my $xmin;
my $xmax;
my $text;
my $durt;

foreach $name(@list) 
{
	print "$name\n";
	open IN,"$name.TextGrid";
	open OUT,">fullrttm_$name";
	while (<IN>)
	{
		chomp;
		$line=$_;
		$line=~s/\s+//g;
		if (!$line )
		{
			next;
		}
		@arr=();
		if ( $line =~ m/item\[(\d)\]\:/g )
		{
			$num = $1;
#			if ($num==1)
#			{
			  while (<IN>)
			  {
				chomp;
				$line=$_;
				$line=~s/\s+//g;
				print "$line\n";
#				last if ($line=~m/item\[/);
				push @arr, $line;
			  }
#		    }

	      for ($i=5;$i<@arr;$i+=4)
           {
				$xmin=$arr[$i+1];
				$xmin=~s/xmin\=//g;
				$xmin=sprintf("%.4f",$xmin);
				$xmax=$arr[$i+2];
				$xmax=~s/xmax\=//g;
				$xmax=sprintf("%.4f",$xmax);
				$text=$arr[$i+3];
				$text=~s/text\=\"//g;
				$text=~s/\"//g;
				$durt=sprintf("%.4f",$xmax - $xmin );
				if ($text)
				{
					print OUT "$name 0 $xmin $durt <NA> <NA> $text <NA> <NA>\n";
				}
				else
			    {
					print OUT "$name 0 $xmin $durt <NA> <NA> other <NA> <NA>\n";
				}
				
			}
	   }
	}
    close IN;
	close OUT;
}

