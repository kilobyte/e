#!/usr/bin/perl -w

my @files;
my $cut;

my @EDITOR = split(' ', $ENV{EDITOR} //"/usr/bin/sensible-editor");

if (!@ARGV)
    { exec @EDITOR; }
if ($ARGV[0] eq '-:')
    { $cut=1; }
elsif ($ARGV[0] eq '-::')
    { $cut=2; }

unless ($cut)
{
    for (@ARGV)
    {
        s/:$//;
        my $line=0;
        $line=$1 if (s/:(\d+)(?:|:\d+)$//);

        push @files, "+$line" if $line;
        push @files, $_;
    }
}
else
{
    @files=@ARGV[1..-1];
    my $re=($cut==1) ? '([^: \t]+)(?:$|:|:(\d+)[: \t\r\n])'
                     : '([^: \t]+):(\d+)(?::\d+)?(?:$|:)';
    while(<STDIN>)
    {
        next unless /$re/;
        my $f=$1;
        chomp $f;
        push @files, "+$2" if defined $2;
        push @files, $f;
    }

    open STDIN, "</dev/tty" or die "Can't open /dev/tty: $!\n";
}

die "No files to edit!\n" unless 1+$#files;

exec @EDITOR, @files;
