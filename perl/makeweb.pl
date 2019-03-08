#
# first argument is the base "project" name, all filenames are created from there:
#
# EXAMPLE: base = HELLO
#
# INPUT file = HELLO_input.txt 
#
# BACK boilerplate file = HELLO_vback.txt   
#
# FRONT boilerplate file = HELLO_vfront.txt   
#
# OUTPUT HTML file = HELLO_vtest.html
#
#

@out = (); ## all HTML output goes here (will be written to output at end)

#
$mybase = $ARGV[0];
##print "mybase= $mybase \n";
##exit 0;
my $output_filename = $mybase . "_vtest.html";   
    my $MYOO   = undef;     # this will be filled in on success
    open($MYOO, "> ", $output_filename)
        || die "$0: can't open $output_filename for writing: $!";
my $front_filename = $mybase . "_vfront.txt";   
    my $front_handle   = undef;     # this will be filled in on success
    open($front_handle, "< ", $front_filename)
        || die "$0: can't open $front_filename for reading: $!";
while (<$front_handle>)
{
	$content = $_;
	push @out,   $content; ## copy contents
}
close $front_handle or die "CANNOT CLOSE $front_filename after reading";
# read 4 line groups, make up left-right image layouts (vanilla)
# 1 = title 2 = text 3 = thumb 4 = pic
#
@pics = ();
@thumbs = ();
@texts = ();
@titles = ();
$state = 1;
my $input_filename = $mybase . "_input.txt";   
    my $input_handle   = undef;     # this will be filled in on success
    open($input_handle, "< ", $input_filename)
        || die "$0: can't open $input_filename for reading: $!";
while (<$input_handle>)
{
	chop;
	if ($state == 1)
	{
		push @titles , $_;
		$state = 2;
	}
	else
	{
		if ($state == 2)
		{
			push @texts , $_;
			$state = 3;
		}
		else
		{
			if ($state == 3)
			{
				push @thumbs , $_;
				$state = 4;
			}
			else
			{
				if ($state == 4)
				{
					push @pics , $_;
					$state = 1;
				}
			}
		}
	} # end not state 1
} ## end input
close $input_handle or die "CANNOT CLOSE $input_filename after reading";
	
#print @thumbs . "\n";

#print "$thumbs[1]  $texts[1]\n"; 

$left_right = 0;
$position = 0;

foreach (@thumbs)
{
	#print;
	#print "\n";
	$this_thumb = $_;
	push @out, '<section class="p-strip--accent">' . "\n"; ## each in an 'accent' section
	push @out,  '<div class="row">' . "\n"; # new row
	push @out ,  '<div class="col-6 u-vertically-center">'; # both sides same size
	if ($left_right == 0)
	{
		# left, row already started
		push @out,   ' <p>  <span class="pic_title">  ' . "$titles[$position]\n"; # text starts with title
		push @out,  "</span> -- $texts[$position]\n</p> </div> <!-- end text group -->" . '<div class="col-6 u-vertically-center"> <p> <br/>';
		push @out, '<a href="' . $pics[$position] . '">';
		push @out,   '<img src="' . $this_thumb . '" alt="[' .
			$titles[$position] . ']" style="color:black;border:solid;border-width:2px"/></a> </p>' . "\n";
		push @out,   "</div> <!-- end picture group --> </div> <!-- end row -->\n";
		push @out,  "</section>\n"; ## each in an accent section
		$left_right = 1;
	} ## end left
	else
	{
		# right, row already started
		push @out,  ' <p> <br/>';
		push @out,  '<a href="' . $pics[$position] . '">';
		push @out,  '<img src="' . $this_thumb . '" alt="[' .
			$titles[$position] . ']" style="color:black;border:solid;border-width:2px"/></a> </p>' . "\n";
		push @out,  "</div> <!-- end picture group --> \n";
		push @out,  '<div class="col-6 u-vertically-center"> <p>  <span class="pic_title">  ' . "$titles[$position]\n"; # text starts with title
		push @out,   "</span> --  $texts[$position]\n</p> </div> <!-- end text group -->\n";
		push @out,  "</div> <!-- end row -->\n";
		push @out,  "</section>\n"; ## each in an accent section
		$left_right = 0; # alternate
	}
	$position++; ## advance to next items in lists
} ## end for each pic
my $back_filename = $mybase . "_vback.txt";   
    my $back_handle   = undef;     # this will be filled in on success
    open($back_handle, "< ", $back_filename)
        || die "$0: can't open $back_filename for reading: $!";
while (<$back_handle>)
{
	## check for DATE_FIELD, so we substitute the current date
	if (/^DATE_FIELD/)
	{
		push @out,  `date`;
	}
	else
	{
		$content = $_;
		push @out,$content ; ## copy contents
	}
}
close $back_handle or die "CANNOT CLOSE $back_filename after reading";
# @out has the web content
  for my $line (@out) {
	print $MYOO $line;
    }
close $MYOO or die "CANNOT CLOSE $output_filename after writing";
