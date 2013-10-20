use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
#my $dbpath = File::Spec->catfile($basedir, 'db', 'development.db');
+{
    'DBI' => [
        "dbi:mysql:database=test;host=localhost;port=3306",
#         "dbi:SQLite:dbname=$dbpath", '', '',
#        +{
#            sqlite_unicode => 1,
#        }
    ],
    'DBH' => +{
        dsn => 'dbi:mysql:dbname=test',
        user => 'root',
        pass => '',
    },
    'PASSWORD_HASH_SALT' => 'HAAAAAAAAAGE',
};
