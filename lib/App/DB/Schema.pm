package App::DB::Schema;
use strict;
use warnings;
use Teng::Schema::Declare;
table {
    name 'sessions';
    pk 'id';
    columns (
        {name => 'id', type => 1},
        {name => 'session_data', type => 12},
    );
};

table {
    name 'sessions2';
    pk 'id';
    columns (
        {name => 'id', type => 1},
        {name => 'session_data', type => 12},
    );
};

table {
    name 'user';
    pk 'id';
    columns (
        {name => 'id', type => 4},
        {name => 'username', type => 12},
        {name => 'password', type => 12},
    );
};

1;
