#!/usr/bin/perl -w

my (@files, %lines);

for (@ARGV)
{
    s/:$//;
    my $line=0;
    $line=$1 if (s/:(\d+)$//);

    if (defined $lines{$_})
    {
        print STDERR "Warning: file specified twice: $_, ignoring.\n";
        next;
    }

    push @files, "+$line" if $line;
    push @files, $_;
    $lines{$@}=$line;
}

die "No files to edit!\n" unless 1+$#files;

exec "/usr/bin/jstar", @files;
