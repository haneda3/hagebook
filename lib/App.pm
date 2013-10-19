package App;
use strict;
use warnings;
use utf8;
use parent qw/Amon2/;
our $VERSION='3.85';
use 5.008001;
use App::DB;
use App::DB::Schema;

__PACKAGE__->load_plugin(qw/DBI/);
__PACKAGE__->load_plugin('DataValidator');

# initialize database
use DBI;
sub setup_schema {
    my $self = shift;
#    my $dbh = $self->dbh();
#    my $driver_name = $dbh->{Driver}->{Name};
#    my $fname = lc("sql/${driver_name}.sql");
#    open my $fh, '<:encoding(UTF-8)', $fname or die "$fname: $!";
#    my $source = do { local $/; <$fh> };
#    for my $stmt (split /;/, $source) {
#        next unless $stmt =~ /\S/;
#        $dbh->do($stmt) or die $dbh->errstr();
#    }
}

sub teng {
    my $self = shift;
    my $db   = App::DB->new(
        dbh    => $self->dbh(),
        schema => App::DB::Schema->instance()
    );
    return $db;
}
use Data::Dumper;
#use App::Model::User;
sub model {
    my ($self, $name) = @_;

    my $class_name = "App::Model::" . $name;
    eval "use $class_name;";
    if ($@) {
        die "Error $@\n";
    }
    my $cls = new $class_name;
    $cls->c($self);

    return $cls;
}

1;
