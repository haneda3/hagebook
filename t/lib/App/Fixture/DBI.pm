package Test::MyApp::Fixture::DBI;
use strict;
use warnings;
use DBI;
use Test::mysqld;
use Test::Fixture::DBI
qw(construct_database construct_fixture);
use DBIx::DBHResolver;
use Exporter 'import';

our @EXPORT = qw(start_mysql setup_database dbh);

sub start_mysql {
    my %config = @_;
    return Test::mysqld->new(my_cnf => +{
            'skip-networking' => '', %config,
        });
}

sub dbh {
    my ($dbname, $opts) = @_;
    DBI->connect(
        $mysqld->dsn(dbname => $dbname),
        'root',
        '',
        {
            AutoCommit => 1,
            RaiseError => 1,
            %$opts,
        },
    );
}

sub setup_database {
    my ($dbname, $fixtures) = @_;
    my $db_yaml = "t/schema/$dbname.yaml";

    my $dbh = dbh('mysql');
    $dbh->do("CREATE DATABASE IF NOT EXISTS $dbname");
    $dbh->do("USE $dbname");

    # データベースをsetup
    construct_database(
        dbh => $dbh,
        database => $db_yaml,
    );

    $dbh->{AutoCommit} = 0;

    # テーブルのデータを入れる
    for my $fixture (@$fixtures) {
        construct_fixture(
            dbh => $dbh,
            fixture => "$fixture",
        );
    }
}

1;


