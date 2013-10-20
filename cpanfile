requires 'perl',                          '5.16.3';
requires 'Amon2',                         '3.85';
requires 'Text::Xslate',                  '1.6001';
requires 'Amon2::DBI'                     , '0.30';
requires 'DBD::SQLite'                    , '1.33';
requires 'HTML::FillInForm::Lite'         , '1.11';
requires 'JSON'                           , '2.50';
requires 'Module::Functions'              , '2';
requires 'Plack::Middleware::ReverseProxy', '0.09';
requires 'Plack::Middleware::Session'     , '0';
requires 'Plack::Session'                 , '0.14';
requires 'Test::WWW::Mechanize::PSGI'     , '0';
requires 'Time::Piece'                    , '1.20';
requires 'DBD::mysql',                      '0';
requires 'Teng',                            '0';
requires 'Data::Validator',                 '0';
requires 'FormValidator::Lite',             '0';
requires 'Router::Simple',                  '0';
requires 'Router::Simple::Sinatraish',      '0';

on 'configure' => sub {
    requires 'Module::Build', '0.38';
    requires 'Module::CPANfile', '0.9010';
};

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::mysqld', '0';
    requires 'Test::Fixture::DBI' ,'0';
};
