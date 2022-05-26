use strict;
use Test::More 0.98;
use JSON::XS;
use Cart::Kata;

my $test_cart = Cart::Kata->new;

my $test_shopping_list = get_list($test_cart);

for my $line (@$test_shopping_list) {

    $test_cart->add_item_line($line);
}

my $subt = $test_cart->subtotal;
diag( "subtotal: $subt" );
ok( $subt > 0, "nonzero subtotal ( = $subt )" );

done_testing;

sub get_list {
    my $cart = shift;
    $cart->get_json('t/data-set-1.json');
}
