#!/usr/bin/perl
use File::Basename;

open IN,"list";
my @textgrid_list;
chomp(@textgrid_list=<IN>);
close IN;

$seg_wav = 0;

for ( $i = 0; $i < @textgrid_list; ++$i )
{
    $textgrid = $textgrid_list[$i];
	print "$textgrid\n";
	open IN,"$textgrid.TextGrid";
	open OUT,">fullrttm_$textgrid";

    $num = 0;
	$nn = 0;
	while ( $nn < 8 )
	{
		chomp($line = <IN>);
		$nn++;

	}
	while ( $line = <IN> )
	{
		chomp $line;
		print "$line\n";
		$line =~ s/\s+//g;
		if ( !$line )
		{
			next;
		}	
		if ( $line =~ m/item\[\d\]\:/g )
		{
			$nn = 0;
			while ( $nn < 6 )
			{
				chomp($line = <IN>);
				$nn++;
			}
		}
		$beg_time = <IN>;
        ++$nn;
        chomp($beg_time);
		$beg_time=~ s/\s+//g;
        $beg_time=~s/xmin\=//g;
        $beg_time=sprintf("%.4f",$beg_time);

        $end_time = <IN>;
        ++$nn;
        chomp($end_time);
		$end_time=~ s/\s+//g;
        $end_time=~s/xmax\=//g;
        $end_time=sprintf("%.4f",$end_time);

		$durt=sprintf("%.4f",$end_time - $beg_time);

		$txt = <IN>;
        chomp($txt);
		$txt=~ s/\s+//g;
		$txt=~s/text\=\"//g;
		$txt=~s/\"//g;

		if ($txt)
		{
		   print OUT "$textgrid 1 $beg_time $durt <NA> <NA> $txt <NA> <NA>\n";
		}
		else
		{
		   print OUT "$textgrid 1 $beg_time $durt <NA> <NA> other <NA> <NA>\n";
		}
	}
    close IN;
    close OUT;
}
