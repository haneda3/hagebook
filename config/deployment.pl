use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), '..'));
#my $dbpath = File::Spec->catfile($basedir, 'db', 'deployment.db');
+{
    'DBI' => [
#        "dbi:SQLite:dbname=$dbpath", '', '',
#        +{
#            sqlite_unicode => 1,
#        }
         "dbi:mysql:database=test;host=localhost;port=3306",
    ],
};
