#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.12.0;
use autodie;
use DBI;
use Teng::Schema::Dumper;
use File::Basename qw(dirname);
use App;

my $c = App->new();
my $db_config = App->config->{DBI} || die "Missing configuration for DBI";
my $base_dir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
my $teng_dir = $base_dir . '/lib/App/DB/';
my $teng_file = 'Schema.pm';

my $dbh = DBI->connect(@$db_config) or die;

my $code = Teng::Schema::Dumper->dump(
    dbh       => $dbh,
    namespace => 'App::DB',
    #inflate   => +{
    #},
);
my $output_file = Cwd::realpath($teng_dir . $teng_file);
open(DATAFILE, ">", $output_file) or die;
print DATAFILE $code;
close(DATAFILE);

print "success!\n";
print "output: $output_file\n";

