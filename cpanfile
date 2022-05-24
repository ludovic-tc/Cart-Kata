requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

requires 'Moo';
requires 'namespace::clean';
requires 'strictures';
requires 'Test::MockModule', '0.177.0'; # only version tested
requires 'Path::Tiny';
requires 'JSON::XS';
