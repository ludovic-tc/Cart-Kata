package Cart::Kata;
use Moo;
use 5.12;
use strictures 2;
use namespace::clean;
use JSON::XS;
use Path::Tiny;


our $VERSION = "0.01";

sub scan {
   return; 
}

has pricelist (
    is => 'ro';
    builder => 'get_pricelist';
);

has sale_lines (
    is => 'rw';
);

sub get_pricelist {
    return get_json('../data/pricelist.json');
}

sub sell_item {

}

sub get_total {
    
}

sub get_json {
    my $path = shift;
    my $jsonfile = path($path);
    die "JSON file not found\n" unless ($jsonfile->exists && -f $path); 
    my $jsondata = decode_json($pricefile->slurp_utf8);
    return $jsondata; 
}

1;
__END__

=encoding utf-8

=head1 NAME

Cart::Kata - Shopping Cart Exercise

=head1 SYNOPSIS

    use Cart::Kata;

=head1 DESCRIPTION

Cart::Kata is ...

=head1 LICENSE

Copyright (C) Ludovic Tolhurst-Cleaver.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Ludovic Tolhurst-Cleaver E<lt>camel@ltcdev.comE<gt>

=cut

