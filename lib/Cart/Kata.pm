package Cart::Kata;
use Moo;
use v5.12;
use strict;
use Carp;
use namespace::clean;
use JSON::XS;
use Path::Tiny;
use List::Util qw(sum0);

our $VERSION = "0.01";

has pricelist => (
    is => 'ro',
    builder => '_get_pricelist',
);

has sale_lines => (
    is => 'ro',
    default => sub { return [] },
);


sub add_item_line {

    my $self = shift;
    my $order_line = shift;

    # verify code & amt
    die "Item code '$order_line->{code}' is not a valid code." unless $order_line->{code} =~ /[A-Za-z]+/;
    die "Quantity '$order_line->{quantity}' is not a whole number." unless $order_line->{quantity} =~ /\d+/;

    # calculate line total
    my $tariff = $self->pricelist->{$order_line->{code}};
    if ($tariff->{multibuy}) {
        my ($deal_amount, $deal_price) = ($tariff->{multibuy} =~ m/(\d+) for (\d+)/);
        my $multibuys = sprintf('%u', $order_line->{quantity} / $deal_amount);
        my $remainder_buys = $order_line->{quantity} % $deal_amount;
        $order_line->{line_price} = $multibuys * $deal_price;
        $order_line->{line_price} += $remainder_buys * $tariff->{price};
    } else {
        $order_line->{line_price} = $order_line->{quantity} * $tariff->{price};
    }

    # add to sale_lines
    push @{$self->sale_lines}, $order_line;
    
}

sub subtotal {

    my $self = shift;
    # calc latest subtotal & return
    my $subtotal = sum0 map {$_->{line_price}} @{$self->sale_lines};
    #my $subtotal = join ',', map {$_->{line_price}} @{$self->sale_lines};
    return $subtotal;

}

sub get_json {

    my ($self, $path) = @_;
    my $jsonfile = path($path);
    die "JSON file $path not found\n" unless ($jsonfile->exists && -f $path);
    my $jsondata = decode_json($jsonfile->slurp_utf8);
    return $jsondata;

}

sub _get_pricelist {

    my $self = shift;
    my $pricelist = $self->get_json('data/pricelist.json');
    for my $code (keys %$pricelist) {
        unless ( $code =~ /[A-Za-z]+/ &&
            $pricelist->{$code}->{price} =~ /\d+/) {
            die "Price list is not in a valid format.\n"
        };
        if ($pricelist->{$code}->{multibuy}) {
            unless ( $pricelist->{$code}->{multibuy} =~ /\d+ for \d+/) {
                die "Price list is not in a valid format.\n"
            };
        }
    }
    return $pricelist;
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

