#!/usr/bin/perl -w

my @files;

for (@ARGV)
{
    s/:$//;
    my $line=0;
    $line=$1 if (s/:(\d+)$//);

    push @files, "+$line" if $line;
    push @files, $_;
}

die "No files to edit!\n" unless 1+$#files;

exec $ENV{'EDITOR'}//"/usr/bin/jstar", @files;
