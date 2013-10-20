package t::Util;
BEGIN {
    unless ($ENV{PLACK_ENV}) {
        $ENV{PLACK_ENV} = 'test';
    }
    if ($ENV{PLACK_ENV} eq 'deployment') {
        die "Do not run a test script on deployment environment";
    }
}
use File::Spec;
use File::Basename;
use lib File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..', 'extlib', 'lib', 'perl5'));
use lib File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..', 'lib'));
use parent qw/Exporter/;
use Test::More 0.98;
use Test::mysqld;

our @EXPORT = qw(slurp);

{
    # utf8 hack.
    binmode Test::More->builder->$_, ":utf8" for qw/output failure_output todo_output/;
    no warnings 'redefine';
    my $code = \&Test::Builder::child;
    *Test::Builder::child = sub {
        my $builder = $code->(@_);
        binmode $builder->output,         ":utf8";
        binmode $builder->failure_output, ":utf8";
        binmode $builder->todo_output,    ":utf8";
        return $builder;
    };
}


sub slurp {
    my $fname = shift;
    open my $fh, '<:encoding(UTF-8)', $fname or die "$fname: $!";
    do { local $/; <$fh> };
}

sub _dbh {
    my ($mysqld, $dbname) = @_;
    DBI->connect( $mysqld->dsn(dbname => $dbname ),
        'root', '', +{ AutoCommit => 0, RaiseError => 1, } );
}

# initialize database
use App;
use Test::Fixture::DBI;
use Data::Dumper;

sub _create_db {
    my ($dbh, $dbname) = @_;
    
    $dbh->do("CREATE DATABASE IF NOT EXISTS test");
    $dbh->do("USE test");

    # create table
    construct_database(
        dbh      => $dbh,
        database => "t/fixture/$dbname/schema.yaml",
    );

    # insert data
    construct_fixture(
        dbh     => $dbh,
        fixture => "t/fixture/$dbname/fixture.yaml",
    );
}

{
    my $mysqld = Test::mysqld->new(
        my_cnf => { 'skip-networking' => '' }, # TCP接続を使わない
    )  or plan skip_all => $Test::mysqld::errstr;

    my $dbh = _dbh($mysqld, 'test');
    
    my $dbs = App->config->{db};
    foreach my $name (keys %$dbs){
        _create_db($dbh, $name);
        my $config = App->config->{db}->{$name};
        $config->{dsn} = $mysqld->dsn;
     }
    $ENV{DBH} = $dbh;
    $ENV{MYSQLD} = $mysqld;

    #my $db_name = 'test';
    #my $dbh = _dbh($mysqld, $db_name);

    #$dbh->do("CREATE DATABASE IF NOT EXISTS $db_name");
    #$dbh->do("USE $db_name");

    # create table
    #construct_database(
    #    dbh      => $dbh,
    #    database => 't/lib/schema.yaml',
    #);

    # insert data
    #construct_fixture(
    #    dbh     => $dbh,
    #    fixture => 't/lib/fixture.yaml',
    #);

    # keep mysqld
    #$ENV{MYSQLD} = $mysqld;

    #my $config = App->config->{DBH}->{user};
    #$config->{dsn} = $mysqld->dsn;
}

1;
