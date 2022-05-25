package Cart::Kata;
use Moo;
use 5.12;
use strict;
use Carp;
use namespace::clean;
use JSON::XS;
use Path::Tiny;

use constant BARCODE_DEVICE_AVAILABLE => 0;

our $VERSION = "0.01";

has pricelist (
    is => 'ro';
    builder => '_get_pricelist';
);

has sale_lines (
    is => 'rw';
);

sub scan {

    my $item_code; 

    # XXX barcode polling not yet implemented
    unless (BARCODE_DEVICE_AVAILABLE) {
        $item_code = STDIN; 
    }

    # data check    
    unless ($item_code =~ /0-9*/) {
        carp "Bad item code: $ite_code\nItem codes must be numeric.\n";
        return; 
    }

    return $item_code;
}

sub sell_item {
    
    # get code
    # add to order lines
    # tot up? no: put in subtotal
    
}

sub subtotal {

    # calc latest subtotal & return

}

sub get_json {
    my $path = shift;
    my $jsonfile = path($path);
    die "JSON file not found\n" unless ($jsonfile->exists && -f $path); 
    my $jsondata = decode_json($pricefile->slurp_utf8);
    return $jsondata; 
}

sub _get_pricelist {
    return get_json('../data/pricelist.json');
}

1;
__END__

=pod

=encoding utf-8

=head1 NAME

Cart::Kata - Shopping Cart Exercise

=head1 SYNOPSIS

    use Cart::Kata;

=head1 DESCRIPTION

Cart::Kata provides a working solution for the SpareRoom shopping cart recruitment challenge. 

=head1 PUBLIC METHODS

=head2 scan

B<Not fully implemented:> 

Polling a scanning device for a barcode is not yet implemented. 

Instead, the item code can be accepted from STDIN. 

=head2 sell_item

Accepts input via @_ if available. 

Otherwise, calls B<scan()> to acquire the next barcode. 

=head1 LICENSE

Copyright (C) Ludovic Tolhurst-Cleaver.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Ludovic Tolhurst-Cleaver E<lt>camel@ltcdev.comE<gt>

=cut

