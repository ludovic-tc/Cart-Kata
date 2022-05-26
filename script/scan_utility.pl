use warnings;
use strict;
use v5.12;

use Cart::Kata;

=pod

=head1 scan utility for Cart::Kata

As barcode polling is not yet implemented, this script allows a sale
to be input manually at the command line.

=cut

my $cart = Cart::Kata->new;

{
    say "Enter item code and quantity, separated by a space.\nE.g.: A 3";
    my $input = <STDIN>;
    exit 0 if $input =~ /quit/i;
    unless ($input =~ /([A-Za-z]+) (\d+)/) {
        "Item code and/or quantity not recognised.";
        next;
    }

    $cart->add_item_line({ code => $1, quantity => $2 });
    say "subtotal: ", $cart->subtotal;

}

# data verification
unless ($item_code =~ /[A-Za-z]+/) {
    carp "Bad item code: $item_code\nItem codes must be numeric.\n";
    return;
}

$self->add_item_line();

