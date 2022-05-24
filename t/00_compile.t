use strict;
use Test::More 0.98;
use Test::MockModule; 
use JSON::XS;

use_ok $_ for qw(
    Cart::Kata
);

my $test_shop = ;

{
    my $test_cart = Test::MockModule->new('Cart::Kata');
    
    for ($prices) {
        $test_cart->scan; 
    }
}

done_testing;

sub get_json {
    my $pricefile = path('../data/pricelist.json');
    my $prices = decode_json($pricefile->slurp_utf8);
    return $prices; 
}
